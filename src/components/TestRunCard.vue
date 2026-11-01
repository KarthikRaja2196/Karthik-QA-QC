<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'

interface TestItem {
  name: string
  time: string
  detail?: string
}

interface SuiteTab {
  id: 'playwright' | 'api' | 'cicd' | 'ai'
  label: string
  icon: string
  cmd: string
  runner: string
  totalTests: number
  estDuration: string
  tests: TestItem[]
}

const suites: SuiteTab[] = [
  {
    id: 'playwright',
    label: 'Playwright (E2E)',
    icon: '🎭',
    cmd: 'npx playwright test --shard=1/4 --workers=4',
    runner: 'Running 8 E2E specs across Chromium & WebKit',
    totalTests: 8,
    estDuration: '9.5s',
    tests: [
      { name: 'checkout › guest can place order with Stripe 3DS', time: '1.8s' },
      { name: 'auth › SSO Google login redirects with auth cookie', time: '0.9s' },
      { name: 'cart › discount promo code calculates 15% off', time: '1.2s' },
      { name: 'search › facet filters persist through browser back/forward', time: '1.4s' },
      { name: 'profile › address validation blocks malformed postal code', time: '0.7s' },
      { name: 'dashboard › charts render without layout shifts', time: '1.1s' },
      { name: 'checkout › cart updates dynamically across 2 tabs', time: '1.3s' },
      { name: 'visual › checkout review page matches pixel baseline', time: '1.1s' },
    ],
  },
  {
    id: 'ai',
    label: 'AI Self-Healing',
    icon: '🧠',
    cmd: 'playwright-ai test --heal --neural-vision',
    runner: 'AI Neural Agent active · Self-healing dynamic DOM changes',
    totalTests: 5,
    estDuration: '4.2s',
    tests: [
      { name: 'checkout › [AI HEALED] #pay-button → button[data-testid="pay-now"]', time: '42ms' },
      { name: 'auth › [AI VISION] Detected 0 layout regressions on modal', time: '180ms' },
      { name: 'fuzz › [LLM SYNTH] Generated 50 edge-case international inputs', time: '210ms' },
      { name: 'triage › [AI TRIAGE] Categorized failure: 0% code flake (99.8% server latency)', time: '65ms' },
      { name: 'suite › [AUTO RECOVERY] 100% test pass with zero human manual intervention', time: '1.2s' },
    ],
  },
  {
    id: 'api',
    label: 'REST API (Contract)',
    icon: '⚡',
    cmd: 'mvn test -Dsuite=testng-api-regression.xml',
    runner: 'Executing RestAssured JSON Schema & Contract tests',
    totalTests: 6,
    estDuration: '3.4s',
    tests: [
      { name: 'POST /v2/auth/oauth/token › 200 OK (JWT structure valid)', time: '142ms' },
      { name: 'GET /v2/orders/ORD-9421 › 200 OK (Contract schema pass)', time: '88ms' },
      { name: 'POST /v2/payments/charge › Idempotency key prevents duplicate', time: '195ms' },
      { name: 'GET /v2/inventory/sku/SKU-802 › 200 OK (Stock accurate)', time: '64ms' },
      { name: 'PUT /v2/users/me/profile › 400 Bad Request on invalid email', time: '52ms' },
      { name: 'POST /v2/webhooks/stripe › HMAC SHA256 signature verified', time: '110ms' },
    ],
  },
  {
    id: 'cicd',
    label: 'CI/CD Pipeline',
    icon: '🚀',
    cmd: 'gh workflow run e2e-matrix.yml --ref=main',
    runner: 'Matrix runner (4 parallel runners in GitHub Actions)',
    totalTests: 4,
    estDuration: '14.2s',
    tests: [
      { name: 'matrix.shard-1/4 › 45 tests passed on ubuntu-latest', time: '3.8s' },
      { name: 'matrix.shard-2/4 › 45 tests passed on ubuntu-latest', time: '4.1s' },
      { name: 'matrix.shard-3/4 › 45 tests passed on ubuntu-latest', time: '3.9s' },
      { name: 'matrix.shard-4/4 › 42 tests passed on ubuntu-latest', time: '3.7s' },
    ],
  },
]

const activeTab = ref<'playwright' | 'api' | 'cicd' | 'ai'>('playwright')
const currentSuite = computed(() => suites.find((s) => s.id === activeTab.value)!)

const reduceMotion = typeof window !== 'undefined' && window.matchMedia('(prefers-reduced-motion: reduce)').matches
const step = ref(reduceMotion ? currentSuite.value.tests.length : 0)
const wait = ref(0)
let timer: ReturnType<typeof setInterval> | undefined

const shown = computed(() => currentSuite.value.tests.slice(0, step.value))
const done = computed(() => step.value >= currentSuite.value.tests.length)
const pct = computed(() => `${Math.round((step.value / currentSuite.value.tests.length) * 100)}%`)

function tick() {
  if (step.value < currentSuite.value.tests.length) {
    step.value++
  } else if (wait.value < 8) {
    wait.value++
  } else {
    step.value = 0
    wait.value = 0
  }
}

function rerun() {
  step.value = 0
  wait.value = 0
}

function setTab(tab: 'playwright' | 'api' | 'cicd' | 'ai') {
  activeTab.value = tab
  step.value = 0
  wait.value = 0
}

watch(activeTab, () => {
  step.value = 0
  wait.value = 0
})

onMounted(() => {
  if (!reduceMotion) {
    timer = setInterval(tick, 520)
  }
})

onBeforeUnmount(() => {
  if (timer) clearInterval(timer)
})
</script>

<template>
  <div class="run-card float">
    <!-- Tab Selector -->
    <div class="tab-bar">
      <div class="lights" aria-hidden="true">
        <span class="l-red"></span>
        <span class="l-yellow"></span>
        <span class="l-green"></span>
      </div>

      <div class="tab-buttons">
        <button
          v-for="s in suites"
          :key="s.id"
          type="button"
          class="tab-btn mono"
          :class="{ active: activeTab === s.id }"
          @click="setTab(s.id)"
        >
          <span class="tab-ic">{{ s.icon }}</span>
          <span class="tab-label">{{ s.label }}</span>
        </button>
      </div>

      <button type="button" class="rerun mono" aria-label="Re-run active test suite" @click="rerun">
        ↻ rerun
      </button>
    </div>

    <!-- Terminal Command Line -->
    <div class="cmd-strip mono">
      <span class="prompt">$</span>
      <span class="cmd-text">{{ currentSuite.cmd }}</span>
      <span class="worker-pill">4 parallel workers</span>
    </div>

    <!-- Terminal Body -->
    <div class="run-body mono" aria-live="polite">
      <div class="run-head">
        <span class="spinner-ic" :class="{ spin: !done }">⚡</span>
        {{ currentSuite.runner }}
      </div>

      <div v-for="t in shown" :key="t.name" class="tline">
        <span class="ok" aria-hidden="true">✓</span>
        <span class="name">{{ t.name }}</span>
        <span class="time">{{ t.time }}</span>
      </div>

      <div v-if="done" class="allure-callout">
        <span class="sparkle">✨</span>
        <span>HTML Report & Artifacts: 0 failures, 0 flaky tests detected</span>
      </div>
    </div>

    <!-- Terminal Footer -->
    <div class="run-foot">
      <div class="track-bar">
        <div class="bar-fill" :style="{ width: pct }"></div>
      </div>
      <div class="run-sum mono">
        <span><b>{{ step }} passed</b> · 0 failed · 0 skipped</span>
        <span class="status-badge" :class="{ pass: done }">
          {{ done ? `✓ passed in ${currentSuite.estDuration}` : 'running…' }}
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.run-card {
  border: 1px solid #3d2c6c;
  border-radius: 20px;
  background: #140b28;
  box-shadow: 0 40px 110px -30px rgba(109, 40, 217, 0.7), 0 0 30px rgba(139, 92, 246, 0.2);
  overflow: hidden;
  transition: border-color 0.3s;
}

.run-card:hover {
  border-color: rgba(167, 139, 250, 0.6);
}

.tab-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding: 10px 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  background: #1b1037;
}

.lights {
  display: flex;
  gap: 6px;
}

.lights span {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.l-red { background: #ef4444; }
.l-yellow { background: #f59e0b; }
.l-green { background: #10b981; }

.tab-buttons {
  display: flex;
  gap: 6px;
  overflow-x: auto;
}

.tab-btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  border-radius: 8px;
  background: transparent;
  border: 1px solid transparent;
  color: var(--muted);
  font-size: 11.5px;
  cursor: pointer;
  transition: all 0.2s;
  white-space: nowrap;
}

.tab-btn:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.06);
}

.tab-btn.active {
  background: rgba(109, 40, 217, 0.35);
  color: #fff;
  border-color: rgba(167, 139, 250, 0.4);
  font-weight: 600;
}

.rerun {
  min-height: 28px;
  padding: 0 10px;
  border-radius: 6px;
  border: 1px solid #45347a;
  background: transparent;
  color: #c4b5fd;
  font-size: 11px;
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.2s;
}

.rerun:hover {
  background: rgba(109, 40, 217, 0.3);
  color: #fff;
  border-color: var(--accent);
}

.cmd-strip {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 18px;
  background: rgba(12, 6, 26, 0.85);
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  font-size: 11.5px;
}

.cmd-strip .prompt {
  color: #a78bfa;
  font-weight: 700;
}

.cmd-text {
  color: #e2d9f7;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.worker-pill {
  font-size: 10px;
  padding: 2px 7px;
  border-radius: 4px;
  background: rgba(16, 185, 129, 0.15);
  color: #34d399;
  border: 1px solid rgba(16, 185, 129, 0.3);
  white-space: nowrap;
}

.run-body {
  padding: 18px 20px 8px;
  font-size: 12.5px;
  line-height: 1.95;
  min-height: 290px;
  display: flex;
  flex-direction: column;
}

.run-head {
  color: var(--muted);
  font-size: 12px;
  margin-bottom: 6px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.tline {
  display: flex;
  gap: 10px;
  align-items: baseline;
  opacity: 0;
  transform: translateX(-6px);
  animation: tin 0.3s ease-out forwards;
}

@keyframes tin {
  to { opacity: 1; transform: none; }
}

.ok {
  color: #34d399;
  font-weight: 700;
}

.name {
  flex: 1;
  min-width: 0;
  color: #e8e1f7;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.time {
  color: #9285b8;
  font-size: 11.5px;
}

.allure-callout {
  margin-top: auto;
  padding: 8px 12px;
  border-radius: 8px;
  background: rgba(109, 40, 217, 0.2);
  border: 1px solid rgba(167, 139, 250, 0.3);
  font-size: 11px;
  color: #e0d4fa;
  display: flex;
  align-items: center;
  gap: 8px;
  animation: tin 0.4s ease-out;
}

.run-foot {
  padding: 14px 20px 18px;
}

.track-bar {
  height: 6px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.08);
  overflow: hidden;
}

.bar-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--accent), #a78bfa);
  border-radius: 999px;
  transition: width 0.35s ease;
}

.run-sum {
  margin-top: 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  font-size: 12px;
}

.run-sum b {
  color: #34d399;
}

.status-badge {
  color: var(--muted);
  white-space: nowrap;
}

.status-badge.pass {
  color: #34d399;
  font-weight: 600;
}

.float {
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  50% { transform: translateY(-12px) rotate(-0.4deg); }
}

@media (prefers-reduced-motion: reduce) {
  .float { animation: none; }
  .tline { animation: none; opacity: 1; transform: none; }
}

@media (max-width: 600px) {
  .tab-label {
    display: none;
  }
  .worker-pill {
    display: none;
  }
}
</style>
