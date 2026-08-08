import {
  DeleteVectorsCommand,
  GetVectorsCommand,
  ListIndexesCommand,
  ListVectorsCommand,
  QueryVectorsCommand,
  S3VectorsClient,
} from "@aws-sdk/client-s3vectors";

interface Env {
  AWS_ACCESS_KEY_ID: string;
  AWS_SECRET_ACCESS_KEY: string;
  AWS_SESSION_TOKEN?: string;
  AWS_REGION: string;
  VECTOR_BUCKET_NAME: string;
}

interface VectorRecord {
  key?: string;
  data: number[];
  metadata: unknown;
}

const MAX_TOP_K = 100;
const MAX_VECTORS = 2_000;
const MAX_VECTORS_PAGE = 1_000;

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "content-type": "application/json; charset=utf-8", "cache-control": "no-store" },
  });
}

function assertBucket(bucket: string | null, env: Env): asserts bucket is string {
  if (!bucket || !/^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$/.test(bucket)) throw new Error("Invalid vector bucket");
  if (bucket !== env.VECTOR_BUCKET_NAME) throw new Error("Vector bucket is not allowed");
}

function client(env: Env): S3VectorsClient {
  return new S3VectorsClient({
    region: env.AWS_REGION,
    credentials: {
      accessKeyId: env.AWS_ACCESS_KEY_ID,
      secretAccessKey: env.AWS_SECRET_ACCESS_KEY,
      ...(env.AWS_SESSION_TOKEN ? { sessionToken: env.AWS_SESSION_TOKEN } : {}),
    },
  });
}

async function allVectors(bucket: string, index: string, env: Env): Promise<VectorRecord[]> {
  const sdk = client(env);
  const vectors: VectorRecord[] = [];
  let nextToken: string | undefined;
  do {
    const listed = await sdk.send(new ListVectorsCommand({
      vectorBucketName: bucket,
      indexName: index,
      returnData: true,
      returnMetadata: true,
      maxResults: Math.min(MAX_VECTORS_PAGE, MAX_VECTORS - vectors.length),
      ...(nextToken ? { nextToken } : {}),
    }));
    vectors.push(...(listed.vectors ?? []).map((vector) => ({
      key: vector.key,
      data: vector.data?.float32 ?? [],
      metadata: vector.metadata ?? {},
    })));
    nextToken = listed.nextToken;
  } while (nextToken && vectors.length < MAX_VECTORS);
  return vectors.slice(0, MAX_VECTORS);
}

function page(): Response {
  return new Response(`<!doctype html>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>S3V Explorer</title>
<style>
:root{color-scheme:dark}*{box-sizing:border-box}body{font:15px system-ui;margin:0;background:#080d18;color:#e5e7eb}main{max-width:1400px;margin:auto;padding:28px}.toolbar,.card{background:#111827;border:1px solid #263449;border-radius:12px}.toolbar{display:flex;gap:8px;align-items:center;padding:12px;flex-wrap:wrap}select,input,button{font:inherit;padding:9px 11px;background:#0b1220;color:inherit;border:1px solid #34445c;border-radius:7px}button{cursor:pointer}button:hover{border-color:#60a5fa}h1{margin:0 0 5px}.muted{color:#94a3b8}.error{color:#fca5a5}.layout{display:grid;grid-template-columns:minmax(0,1fr) 340px;gap:14px;margin-top:14px}.card{padding:14px}.plot-wrap{position:relative;height:600px}.plot{display:block;width:100%;height:100%;background:radial-gradient(circle at center,#111d32,#0b1220);border-radius:8px}.empty{position:absolute;inset:0;display:grid;place-items:center;color:#94a3b8;text-align:center;padding:30px}.details{min-height:560px;overflow:auto}.details h2{font-size:18px;overflow-wrap:anywhere}.details pre{white-space:pre-wrap;overflow-wrap:anywhere;color:#cbd5e1}.list-card{margin-top:14px}.list{display:grid;gap:6px;max-height:280px;overflow:auto;margin-top:10px}.vector-row{display:flex;justify-content:space-between;gap:8px;text-align:left;width:100%;overflow:hidden}.vector-row span{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.badge{color:#93c5fd;font-size:12px;white-space:nowrap}@media(max-width:850px){.layout{grid-template-columns:1fr}.details{min-height:0}.plot-wrap{height:440px}}
</style>
<main><h1>S3V Explorer</h1><p id="status" class="muted">Connecting to Amazon S3 Vectors…</p>
<div class="toolbar"><label>Bucket <select id="bucket"></select></label><label>Index <select id="index"></select></label><button id="refresh">Refresh</button></div>
<div class="layout"><section class="card plot-wrap"><canvas id="plot" class="plot"></canvas><div id="empty" class="empty">Loading vectors…</div></section><aside class="card details" id="details"><p class="muted">Select a point or vector.</p></aside></div>
<section class="card list-card"><label>Filter vectors <input id="search" type="search" placeholder="key or metadata"></label><div id="list" class="list"></div></section></main>
<script>
const $=id=>document.getElementById(id);let state={vectors:[],points:[],selected:-1};
const esc=value=>String(value).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
async function api(path,options){const r=await fetch(path,options);let x;try{x=await r.json()}catch{throw Error('The Worker returned an invalid response ('+r.status+')')}if(!r.ok)throw Error(x.error||'Request failed');return x}
function status(message,error=false){$('status').textContent=message;$('status').className=error?'error':'muted'}
function empty(message){$('empty').textContent=message;$('empty').style.display='grid'}
function projection(vectors){if(!vectors.length)return[];const dims=Math.max(...vectors.map(v=>v.data.length),0);if(!dims)return vectors.map(()=>({x:.5,y:.5}));const count=Math.min(dims,96),chosen=Array.from({length:count},(_,i)=>Math.floor(i*dims/count));const means=chosen.map(d=>vectors.reduce((sum,v)=>sum+(v.data[d]||0),0)/vectors.length);const raw=vectors.map(v=>{let x=0,y=0;chosen.forEach((d,i)=>{const z=(v.data[d]||0)-means[i];x+=z*Math.cos(i*2.399963);y+=z*Math.sin(i*2.399963)});return{x,y}});const xs=raw.map(p=>p.x),ys=raw.map(p=>p.y),xmin=Math.min(...xs),xmax=Math.max(...xs),ymin=Math.min(...ys),ymax=Math.max(...ys);return raw.map(p=>({x:xmax===xmin?.5:.08+.84*(p.x-xmin)/(xmax-xmin),y:ymax===ymin?.5:.08+.84*(p.y-ymin)/(ymax-ymin)}))}
function draw(){const canvas=$('plot'),rect=canvas.getBoundingClientRect(),dpr=devicePixelRatio||1;canvas.width=rect.width*dpr;canvas.height=rect.height*dpr;const ctx=canvas.getContext('2d');ctx.scale(dpr,dpr);ctx.clearRect(0,0,rect.width,rect.height);state.points.forEach((p,i)=>{const x=p.x*rect.width,y=(1-p.y)*rect.height;ctx.beginPath();ctx.arc(x,y,i===state.selected?8:5,0,Math.PI*2);ctx.fillStyle=i===state.selected?'#fbbf24':'#60a5fa';ctx.fill();ctx.strokeStyle=i===state.selected?'#fff':'#172554';ctx.lineWidth=2;ctx.stroke()})}
function renderList(){const query=$('search').value.toLowerCase();const rows=state.vectors.map((v,i)=>({v,i,text:(v.key+' '+JSON.stringify(v.metadata)).toLowerCase()})).filter(x=>x.text.includes(query)).slice(0,300);$('list').innerHTML=rows.length?rows.map(({v,i})=>'<button class="vector-row" data-i="'+i+'"><span>'+esc(v.metadata?.trickName||v.key||'(unnamed vector)')+'</span><span class="badge">'+v.data.length+'d</span></button>').join(''):'<span class="muted">No matching vectors.</span>';document.querySelectorAll('.vector-row').forEach(b=>b.onclick=()=>select(Number(b.dataset.i)))}
function select(i){const v=state.vectors[i];if(!v)return;state.selected=i;draw();$('details').innerHTML='<h2>'+esc(v.key||'(unnamed vector)')+'</h2><p class="muted">'+v.data.length+' dimensions</p><pre>'+esc(JSON.stringify(v.metadata,null,2))+'</pre><button id="similar">Find similar</button> <button id="delete">Delete</button>';$('similar').onclick=async()=>{try{const x=await api('/api/query',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({bucket:$('bucket').value,index:$('index').value,key:v.key,topK:10})});$('details').innerHTML+='<h3>Similar vectors</h3><pre>'+esc(JSON.stringify(x,null,2))+'</pre>'}catch(e){status(e.message,true)}};$('delete').onclick=async()=>{if(confirm('Delete '+v.key+'?')){try{await api('/api/vectors',{method:'DELETE',headers:{'content-type':'application/json'},body:JSON.stringify({bucket:$('bucket').value,index:$('index').value,key:v.key})});await loadVectors()}catch(e){status(e.message,true)}}}}
function pick(event){if(!state.points.length)return;const rect=$('plot').getBoundingClientRect(),x=event.clientX-rect.left,y=1-(event.clientY-rect.top)/rect.height;let best=-1,d=Infinity;state.points.forEach((p,i)=>{const dx=p.x-x,dy=p.y-y,dist=dx*dx+dy*dy;if(dist<d){d=dist;best=i}});if(best>=0&&d<.003)select(best)}
async function loadIndexes(){try{status('Loading indexes…');const indexes=await api('/api/indexes?bucket='+encodeURIComponent($('bucket').value));$('index').innerHTML=indexes.map(x=>'<option>'+esc(x)+'</option>').join('');$('index').disabled=!indexes.length;if(!indexes.length){state.vectors=[];state.points=[];renderList();draw();empty('No indexes were returned for this bucket.');status('No indexes found.',true);return}await loadVectors()}catch(e){state.vectors=[];state.points=[];renderList();draw();empty('Unable to load indexes.');status(e.message,true)}}
async function loadVectors(){try{status('Loading vectors…');const index=$('index').value;if(!index)throw Error('Choose an index first.');state.vectors=await api('/api/vectors?bucket='+encodeURIComponent($('bucket').value)+'&index='+encodeURIComponent(index));state.points=projection(state.vectors);state.selected=-1;renderList();draw();empty(state.vectors.length?'':'No vectors were returned for this index.');if(state.vectors.length) $('empty').style.display='none';status('Loaded '+state.vectors.length+' vectors. Click a point or use the list.')}catch(e){state.vectors=[];state.points=[];renderList();draw();empty('Unable to load vectors.');status(e.message,true)}}
async function start(){try{const buckets=await api('/api/buckets');$('bucket').innerHTML=buckets.map(x=>'<option>'+esc(x)+'</option>').join('');$('bucket').onchange=loadIndexes;$('index').onchange=loadVectors;$('refresh').onclick=loadVectors;$('search').oninput=renderList;$('plot').onclick=pick;addEventListener('resize',draw);await loadIndexes()}catch(e){empty('Unable to connect to the viewer API.');status(e.message,true)}}
start();
</script>`, { headers: { "content-type": "text/html; charset=utf-8", "cache-control": "no-store" } });
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (request.method === "GET" && url.pathname === "/") return page();
    try {
      const sdk = client(env);
      if (request.method === "GET" && url.pathname === "/api/buckets") return json([env.VECTOR_BUCKET_NAME]);
      const bucket = url.searchParams.get("bucket");
      assertBucket(bucket, env);
      const index = url.searchParams.get("index");
      if (url.pathname === "/api/indexes" && request.method === "GET") {
        const result = await sdk.send(new ListIndexesCommand({ vectorBucketName: bucket }));
        return json((result.indexes ?? []).map((item) => item.indexName).filter(Boolean));
      }
      if (!index || !/^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$/.test(index)) throw new Error("Invalid vector index");
      if (url.pathname === "/api/vectors" && request.method === "GET") return json(await allVectors(bucket, index, env));
      if (url.pathname === "/api/vectors" && request.method === "DELETE") {
        const body = await request.json<{ key?: string }>();
        if (!body.key || body.key.length > 1_024) throw new Error("Invalid vector key");
        await sdk.send(new DeleteVectorsCommand({ vectorBucketName: bucket, indexName: index, keys: [body.key] }));
        return json({ ok: true });
      }
      if (url.pathname === "/api/query" && request.method === "POST") {
        const body = await request.json<{ key?: string; topK?: number }>();
        if (!body.key || body.key.length > 1_024) throw new Error("Invalid query key");
        const source = await sdk.send(new GetVectorsCommand({ vectorBucketName: bucket, indexName: index, keys: [body.key], returnData: true }));
        const vector = source.vectors?.[0]?.data?.float32;
        if (!vector?.length) throw new Error("Query vector was not found");
        const result = await sdk.send(new QueryVectorsCommand({ vectorBucketName: bucket, indexName: index, queryVector: { float32: vector }, topK: Math.min(Math.max(body.topK ?? 10, 1), MAX_TOP_K), returnMetadata: true }));
        return json((result.vectors ?? []).map((item) => ({ key: item.key, distance: item.distance, metadata: item.metadata ?? {} })));
      }
      return json({ error: "Not found" }, 404);
    } catch (error) {
      console.error(JSON.stringify({ event: "s3v_explorer_error", reason: error instanceof Error ? error.message : "unknown" }));
      return json({ error: error instanceof Error ? error.message : "Request failed" }, 400);
    }
  },
};
