<script setup lang="ts">
import { computed, ref } from 'vue'

const manualHours = ref(40)
const releasesPerMonth = ref(3)
const engineerRate = ref(55)

// With Playwright parallel sharding, 85-92% of repetitive manual execution is automated
const hoursSavedPerRelease = computed(() => Math.round(manualHours.value * 0.88))
const hoursSavedMonthly = computed(() => hoursSavedPerRelease.value * releasesPerMonth.value)
const hoursSavedAnnual = computed(() => hoursSavedMonthly.value * 12)
const dollarsSavedAnnual = computed(() => hoursSavedAnnual.value * engineerRate.value)

// Automated suite runtime with 4-worker sharding
const automatedRuntimeMinutes = computed(() => {
  return Math.max(12, Math.round((manualHours.value * 60 * 0.006) / 2))
})
</script>

<template>
  <div class="calculator-card reveal">
    <div class="calc-header">
      <div class="calc-tag mono">
        <span class="sparkle">📊</span> AUTOMATION ROI ESTIMATOR
      </div>
      <h3 class="calc-title">How much time will an automated suite save your team?</h3>
      <p class="calc-desc">
        Calculate your engineering hours reclaimed and release speedup when converting manual regression into Playwright / Selenium pipelines.
      </p>
    </div>

    <div class="calc-grid">
      <!-- Input Sliders -->
      <div class="calc-inputs">
        <div class="slider-group">
          <div class="slider-label-row">
            <label for="hours-slider" class="mono">Manual Regression Hours / Release</label>
            <span class="slider-val mono">{{ manualHours }} hrs</span>
          </div>
          <input
            id="hours-slider"
            v-model.number="manualHours"
            type="range"
            min="10"
            max="120"
            step="5"
            class="range-slider"
          />
          <div class="range-marks mono">
            <span>10h</span>
            <span>40h (Standard)</span>
            <span>120h</span>
          </div>
        </div>

        <div class="slider-group">
          <div class="slider-label-row">
            <label for="releases-slider" class="mono">Releases / Sprints per Month</label>
            <span class="slider-val mono">{{ releasesPerMonth }} {{ releasesPerMonth === 1 ? 'release' : 'releases' }}</span>
          </div>
          <input
            id="releases-slider"
            v-model.number="releasesPerMonth"
            type="range"
            min="1"
            max="8"
            step="1"
            class="range-slider"
          />
          <div class="range-marks mono">
            <span>1 / mo</span>
            <span>Bi-weekly</span>
            <span>Weekly</span>
          </div>
        </div>

        <div class="stat-highlight-row">
          <div class="highlight-chip">
            <span class="hl-num mono">{{ manualHours }}h → ~{{ automatedRuntimeMinutes }}m</span>
            <span class="hl-label">Regression Turnaround</span>
          </div>
          <div class="highlight-chip">
            <span class="hl-num mono">~88%</span>
            <span class="hl-label">Manual Effort Eliminated</span>
          </div>
        </div>
      </div>

      <!-- Results Display Box -->
      <div class="calc-results">
        <div class="results-inner">
          <div class="res-badge mono">// ANNUAL VALUE PROJECTION</div>

          <div class="res-item big">
            <span class="res-label">Engineering Hours Saved / Year</span>
            <div class="res-val mono">{{ hoursSavedAnnual.toLocaleString() }} <span class="unit">hours</span></div>
          </div>

          <div class="res-divider"></div>

          <div class="res-row">
            <div class="res-sub-item">
              <span class="res-sub-label">Monthly Hours Reclaimed</span>
              <div class="res-sub-val mono">{{ hoursSavedMonthly }} hrs/mo</div>
            </div>
            <div class="res-sub-item">
              <span class="res-sub-label">Estimated Budget Saved</span>
              <div class="res-sub-val mono green">${{ dollarsSavedAnnual.toLocaleString() }}</div>
            </div>
          </div>

          <a href="#contact" class="btn btn-p calc-cta">
            Automate My Test Suite
            <span aria-hidden="true">→</span>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.calculator-card {
  margin-top: 56px;
  background: radial-gradient(circle at 10% 10%, #20133e 0%, #160d2e 60%, #110826 100%);
  border: 1px solid rgba(167, 139, 250, 0.25);
  border-radius: 24px;
  padding: 48px;
  box-shadow: 0 30px 80px -25px rgba(0, 0, 0, 0.8), 0 0 40px -10px rgba(109, 40, 217, 0.25);
  transition: border-color 0.3s;
}

.calculator-card:hover {
  border-color: rgba(167, 139, 250, 0.5);
}

.calc-header {
  max-width: 680px;
}

.calc-tag {
  font-size: 12px;
  color: #c4b5fd;
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.calc-title {
  margin-top: 12px;
  font-size: clamp(26px, 3.2vw, 36px);
  font-weight: 700;
  letter-spacing: -0.02em;
  color: #fff;
}

.calc-desc {
  margin-top: 10px;
  font-size: 16px;
  color: var(--muted);
  line-height: 1.6;
}

.calc-grid {
  margin-top: 40px;
  display: grid;
  grid-template-columns: minmax(0, 1.2fr) minmax(0, 1fr);
  gap: 48px;
  align-items: center;
}

.calc-inputs {
  display: flex;
  flex-direction: column;
  gap: 28px;
}

.slider-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.slider-label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13.5px;
  color: #e2d9f7;
}

.slider-val {
  font-size: 15px;
  font-weight: 700;
  color: #c4b5fd;
  background: rgba(109, 40, 217, 0.25);
  padding: 3px 10px;
  border-radius: 6px;
  border: 1px solid rgba(167, 139, 250, 0.3);
}

.range-slider {
  width: 100%;
  height: 6px;
  -webkit-appearance: none;
  appearance: none;
  background: #2b1c50;
  border-radius: 3px;
  outline: none;
  cursor: pointer;
}

.range-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: #f5f1ff;
  box-shadow: 0 0 12px var(--accent);
  cursor: pointer;
  transition: transform 0.15s;
}

.range-slider::-webkit-slider-thumb:hover {
  transform: scale(1.2);
}

.range-marks {
  display: flex;
  justify-content: space-between;
  font-size: 11px;
  color: #8c7ea8;
}

.stat-highlight-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14px;
  margin-top: 8px;
}

.highlight-chip {
  padding: 14px 16px;
  border-radius: 12px;
  background: rgba(18, 10, 36, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.08);
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.hl-num {
  font-size: 17px;
  font-weight: 700;
  color: #34d399;
}

.hl-label {
  font-size: 12px;
  color: var(--muted);
}

/* Results Box */
.calc-results {
  background: rgba(18, 10, 36, 0.7);
  border: 1px solid rgba(167, 139, 250, 0.3);
  border-radius: 20px;
  padding: 32px;
  box-shadow: inset 0 0 30px rgba(109, 40, 217, 0.2);
}

.results-inner {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.res-badge {
  font-size: 11px;
  color: #c4b5fd;
  letter-spacing: 0.05em;
}

.res-item.big {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.res-label {
  font-size: 13.5px;
  color: var(--muted);
}

.res-val {
  font-size: clamp(38px, 4vw, 52px);
  font-weight: 800;
  color: #fff;
  letter-spacing: -0.03em;
  line-height: 1;
}

.res-val .unit {
  font-size: 18px;
  font-weight: 500;
  color: #a78bfa;
}

.res-divider {
  height: 1px;
  background: rgba(255, 255, 255, 0.1);
}

.res-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.res-sub-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.res-sub-label {
  font-size: 12px;
  color: var(--muted);
}

.res-sub-val {
  font-size: 20px;
  font-weight: 700;
  color: #e2d9f7;
}

.res-sub-val.green {
  color: #34d399;
}

.calc-cta {
  margin-top: 8px;
  justify-content: center;
  width: 100%;
}

@media (max-width: 860px) {
  .calc-grid {
    grid-template-columns: minmax(0, 1fr);
    gap: 36px;
  }
  .calculator-card {
    padding: 32px 24px;
  }
}
</style>
