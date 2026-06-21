<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>🩷 Presenza</title>

<link rel="manifest" href="manifest.json">

<style>
body{
  margin:0;
  font-family: system-ui;
  background:linear-gradient(160deg,#fff0f6,#ffd1e6);
  color:#2a0b14;
}

.app{
  max-width:430px;
  margin:auto;
  padding:16px;
}

.header{
  text-align:center;
  margin-top:10px;
}

.heart{
  font-size:90px;
  animation:pulse 1.5s infinite;
}

@keyframes pulse{
  0%{transform:scale(1);}
  50%{transform:scale(1.12);}
  100%{transform:scale(1);}
}

.grid{
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:10px;
  margin-top:14px;
}

button{
  border:none;
  padding:14px;
  border-radius:16px;
  font-weight:600;
  background:linear-gradient(135deg,#ff4d88,#ff9ecb);
  color:white;
}

.overlay{
  position:fixed;
  inset:0;
  background:rgba(255,240,246,0.98);
  display:none;
  justify-content:center;
  align-items:center;
  padding:20px;
}

.box{
  width:100%;
  max-width:360px;
  background:white;
  padding:18px;
  border-radius:20px;
  text-align:center;
  box-shadow:0 10px 25px rgba(255,77,136,0.15);
}

.cancel{
  background:#2a0b14;
  margin-top:10px;
}

.timer{
  font-size:30px;
  margin:10px 0;
}

.gallery img{
  width:100%;
  margin-top:8px;
  border-radius:12px;
}
</style>
</head>

<body>

<div class="app">

  <div class="header">
    <div class="heart">🩷</div>
    <h3>Io sono qui con te</h3>
  </div>

  <div class="grid">
    <button onclick="openMode('breath')">Respira</button>
    <button onclick="openMode('msg')">Messaggi</button>
    <button onclick="openMode('penso')">🩷 Ti penso</button>
    <button onclick="openMode('gallery')">Ricordi</button>
  </div>

</div>

<!-- BREATH -->
<div class="overlay" id="breath">
  <div class="box">
    <h3>Respirazione</h3>
    <div id="phase">Pronto</div>
    <div class="timer" id="timer">0</div>
    <button class="cancel" onclick="closeMode()">Chiudi</button>
  </div>
</div>

<!-- MSG -->
<div class="overlay" id="msg">
  <div class="box">
    <h3>Messaggi</h3>
    <div id="text">Sono qui con te.</div>
    <button onclick="newMsg()">Altro</button>
    <button class="cancel" onclick="closeMode()">Chiudi</button>
  </div>
</div>

<!-- PENSO -->
<div class="overlay" id="penso">
  <div class="box">
    <h3>🩷 Ti penso</h3>
    <p>In questo momento sono con te.</p>
    <button class="cancel" onclick="closeMode()">Chiudi</button>
  </div>
</div>

<!-- GALLERY -->
<div class="overlay" id="gallery">
  <div class="box">
    <h3>Ricordi 🩷😘</h3>
    <input type="file" multiple accept="image/*" onchange="load(event)">
    <div id="imgs"></div>
    <button class="cancel" onclick="closeMode()">Chiudi</button>
  </div>
</div>

<script>
let active=null;

function openMode(id){
  closeMode();
  active=id;
  document.getElementById(id).style.display="flex";
  if(id==="breath") startBreathing();
}

function closeMode(){
  if(active) document.getElementById(active).style.display="none";
  active=null;
  running=false;
}

/* MESSAGGI */
const msgs=[
 "Sono qui con te.",
 "Non sei sola.",
 "Respira piano.",
 "Passa, anche se ora pesa."
];

function newMsg(){
 document.getElementById("text").innerText =
 msgs[Math.floor(Math.random()*msgs.length)];
}

/* BREATH */
let running=false;
let t=0;
let phase=0;

function startBreathing(){
 running=true;
 const steps=[
  {t:4,label:"Inspira"},
  {t:4,label:"Trattieni"},
  {t:6,label:"Espira"}
 ];

 function loop(){
  if(!running) return;

  if(t<=0){
    phase=(phase+1)%3;
    t=steps[phase].t;
    document.getElementById("phase").innerText=steps[phase].label;
  }

  document.getElementById("timer").innerText=t;
  t--;

  setTimeout(loop,1000);
 }

 loop();
}

/* GALLERY */
function load(e){
 const c=document.getElementById("imgs");
 for(let f of e.target.files){
  const r=new FileReader();
  r.onload=ev=>{
    let img=document.createElement("img");
    img.src=ev.target.result;
    c.appendChild(img);
  }
  r.readAsDataURL(f);
 }
}
</script>

<script>
if('serviceWorker' in navigator){
 navigator.serviceWorker.register('sw.js');
}
</script>

</body>
</html>
