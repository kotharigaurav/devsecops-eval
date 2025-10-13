async function checkStatus(){
  const statusEl = document.getElementById('status');
  try{
    const r = await fetch('/health');
    if(!r.ok) throw new Error('no')
    const j = await r.json();
    statusEl.textContent = j.status || 'UP';
    statusEl.style.color = '#34d399';
  }catch(e){
    statusEl.textContent = 'Unavailable';
    statusEl.style.color = '#fb7185';
  }
}

document.getElementById('refresh').addEventListener('click', (e)=>{e.preventDefault(); checkStatus();});

checkStatus();
