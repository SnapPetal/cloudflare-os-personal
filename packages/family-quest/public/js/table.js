document.addEventListener("alpine:init", () => {
  Alpine.data("questTable", () => ({
    voiceOn: true,
    autoplay: false,
    listening: false,
    voiceLabel: "Narrator on",
    autoplayLabel: "Auto-play off",
    micLabel: "Speak",
    status: "",
    audio: null,
    init() {
      this.voiceOn = localStorage.getItem("fq-voice") !== "off";
      this.autoplay = localStorage.getItem("fq-autoplay") === "on";
      this.refreshLabels();
    },
    refreshLabels() {
      this.voiceLabel = this.voiceOn ? "Narrator on" : "Narrator off";
      this.autoplayLabel = this.autoplay ? "Auto-play on" : "Auto-play off";
      const recognition = window.SpeechRecognition || window.webkitSpeechRecognition;
      if (this.listening) this.micLabel = "Listening…";
      else this.micLabel = recognition ? "Speak" : "Mic unavailable";
    },
    toggleVoice() {
      this.voiceOn = !this.voiceOn;
      localStorage.setItem("fq-voice", this.voiceOn ? "on" : "off");
      this.refreshLabels();
      if (!this.voiceOn) window.speechSynthesis?.cancel();
    },
    toggleAutoplay() {
      this.autoplay = !this.autoplay;
      localStorage.setItem("fq-autoplay", this.autoplay ? "on" : "off");
      this.refreshLabels();
    },
    readLine(element) {
      const line = element?.dataset?.line || "";
      return this.speak(line);
    },
    async speak(text) {
      if (!this.voiceOn || !text) return;
      window.speechSynthesis?.cancel();
      if (this.audio) {
        this.audio.pause();
        this.audio = null;
      }
      const token = document.querySelector('meta[name="fq-csrf"]')?.content || "";
      const quest = document.body.dataset.quest || "";
      try {
        const response = await fetch(`/quests/${quest}/tts`, {
          method: "POST",
          headers: {
            "content-type": "application/json",
            "x-family-quest-token": token,
          },
          body: JSON.stringify({ text }),
        });
        const type = response.headers.get("content-type") || "";
        if (response.ok && type.includes("audio")) {
          const url = URL.createObjectURL(await response.blob());
          this.audio = new Audio(url);
          this.status = "Narrator is speaking.";
          await this.audio.play();
          return;
        }
      } catch (error) {
        this.status = "Cloud voice missed a line. Using the browser voice.";
      }
      this.speakInBrowser(text);
    },
    speakInBrowser(text) {
      if (!window.speechSynthesis || !text) {
        this.status = "This browser has no built-in voice. The text is still on the page.";
        return;
      }
      const utterance = new SpeechSynthesisUtterance(text.slice(0, 1200));
      utterance.rate = 0.95;
      window.speechSynthesis.speak(utterance);
      this.status = "Playing in the browser voice.";
    },
    listen() {
      const Recognition = window.SpeechRecognition || window.webkitSpeechRecognition;
      if (!Recognition) {
        this.status = "This browser does not offer speech input. Typing works.";
        this.refreshLabels();
        return;
      }
      const recognition = new Recognition();
      recognition.lang = "en-US";
      recognition.interimResults = false;
      recognition.maxAlternatives = 1;
      recognition.addEventListener("result", (event) => {
        const said = event.results?.[0]?.[0]?.transcript ?? "";
        if (this.$refs.action) this.$refs.action.value = said;
        this.status = said ? "Heard you. Send when it looks right." : "";
      });
      recognition.addEventListener("error", () => {
        this.status = "The microphone did not catch that. You can type instead.";
      });
      recognition.addEventListener("end", () => {
        this.listening = false;
        this.refreshLabels();
      });
      this.listening = true;
      this.refreshLabels();
      recognition.start();
    },
  }));
});

document.addEventListener("htmx:afterSwap", (event) => {
  if (window.Alpine && event.target) Alpine.initTree(event.target);
});

document.addEventListener("htmx:afterSettle", () => {
  const node = document.querySelector("[data-speak-now]");
  if (!node) return;
  const text = node.getAttribute("data-speak-now") || "";
  node.removeAttribute("data-speak-now");
  if (localStorage.getItem("fq-autoplay") !== "on") return;
  if (localStorage.getItem("fq-voice") === "off") return;
  const root = document.querySelector("[data-quest-table]");
  const data = root && window.Alpine ? Alpine.$data(root) : null;
  if (data && typeof data.speak === "function") data.speak(text);
});
