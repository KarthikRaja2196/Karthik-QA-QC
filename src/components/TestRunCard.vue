<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'

// Illustrative output only — it demonstrates the style of reporting, not a real run.
const tests = [
  { name: 'checkout › guest can place an order', time: '1.8s' },
  { name: 'auth › login with SSO redirects home', time: '0.9s' },
  { name: 'cart › coupon applies 10% discount', time: '1.2s' },
  { name: 'api › GET /orders matches schema', time: '0.3s' },
  { name: 'search › filters persist on reload', time: '1.4s' },
  { name: 'profile › address form validation', time: '0.7s' },
  { name: 'payments › 3DS challenge succeeds', time: '2.1s' },
  { name: 'visual › home page matches baseline', time: '1.1s' },
]

const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches
const step = ref(reduceMotion ? tests.length : 0)
const wait = ref(0)
let timer: ReturnType<typeof setInterval> | undefined

const shown = computed(() => tests.slice(0, step.value))
const done = computed(() => step.value >= tests.length)
const pct = computed(() => `${Math.round((step.value / tests.length) * 100)}%`)

// One test per tick; after the last, hold ~9 ticks on the summary, then restart the run.
function tick() {
  if (step.value < tests.length) step.value++
  else if (wait.value < 9) wait.value++
  else {
    step.value = 0
    wait.value = 0
  }
}

function rerun() {
  step.value = 0
  wait.value = 0
}

onMounted(() => {
  if (!reduceMotion) timer = setInterval(tick, 520)
})
onBeforeUnmount(() => clearInterval(timer))
</script>

<template>
  <div class="run-card float">
    <div class="run-bar">
      <div class="lights" aria-hidden="true"><span></span><span></span><span></span></div>
      <span class="cmd mono">npx playwright test --shard=1/4</span>
      <button type="button" class="rerun mono" aria-label="Re-run test suite" @click="rerun">↻ re-run</button>
    </div>
    <div class="run-body mono" aria-live="polite" aria-label="Sample test run output">
      <div class="run-head">Running {{ tests.length }} tests using 4 workers</div>
      <div v-for="t in shown" :key="t.name" class="tline">
        <span class="ok" aria-hidden="true">✓</span>
        <span class="name">{{ t.name }}</span>
        <span class="time">{{ t.time }}</span>
      </div>
    </div>
    <div class="run-foot">
      <div class="track-bar"><div class="bar-fill" :style="{ width: pct }"></div></div>
      <div class="run-sum mono">
        <span><b>{{ step }} passed</b> · 0 failed · 0 flaky</span>
        <span class="status">{{ done ? 'done in 9.5s' : 'running…' }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.run-card {
  border: 1px solid #36285E;
  border-radius: 18px;
  background: #170E2E;
  box-shadow: 0 40px 110px -30px rgba(109, 40, 217, 0.65);
  overflow: hidden;
}
.run-bar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 14px 18px; border-bottom: 1px solid var(--line); background: var(--surf); }
.lights { display: flex; gap: 8px; }
.lights span { width: 11px; height: 11px; border-radius: 50%; background: #4D3B7E; }
.cmd { font-size: 12px; color: var(--muted); min-width: 0; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.rerun { min-height: 32px; padding: 0 12px; border-radius: 8px; border: 1px solid #45347A; background: transparent; color: var(--text); font-size: 12px; cursor: pointer; white-space: nowrap; transition: background 0.2s; }
.rerun:hover { background: rgba(245, 241, 255, 0.07); }
.run-body { padding: 20px 22px 8px; font-size: 13.5px; line-height: 1.95; min-height: 300px; }
.run-head { color: var(--muted); }
.tline { display: flex; gap: 10px; align-items: baseline; opacity: 0; transform: translateX(-8px); animation: tin 0.35s ease-out forwards; }
@keyframes tin { to { opacity: 1; transform: none; } }
.ok { color: var(--accent-soft); font-weight: 700; }
.name { flex: 1; min-width: 0; color: #E8E1F7; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.time { color: #9285B8; }
.run-foot { padding: 16px 22px 22px; }
.track-bar { height: 6px; border-radius: 999px; background: var(--line); overflow: hidden; }
.bar-fill { height: 100%; background: var(--accent); border-radius: 999px; transition: width 0.4s ease; }
.run-sum { margin-top: 14px; display: flex; justify-content: space-between; gap: 12px; font-size: 13px; }
.run-sum b { color: var(--accent-soft); }
.status { color: var(--muted); white-space: nowrap; }
.float { animation: float 6s ease-in-out infinite; }
@keyframes float { 50% { transform: translateY(-16px) rotate(-0.6deg); } }
@media (prefers-reduced-motion: reduce) {
  .float { animation: none; }
  .tline { animation: none; opacity: 1; transform: none; }
}
@media (max-width: 540px) { .run-body { min-height: 280px; font-size: 12.5px; } }
</style>
