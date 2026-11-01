<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'
import { navLinks, profile } from '../data/content'
import { useAudio } from '../composables/useAudio'

defineProps<{ activeId: string }>()

const open = ref(false)
const { isPlaying, togglePlay } = useAudio()

function onKey(e: KeyboardEvent) {
  if (e.key === 'Escape') open.value = false
}
onMounted(() => window.addEventListener('keydown', onKey))
onBeforeUnmount(() => window.removeEventListener('keydown', onKey))
</script>

<template>
  <nav class="nav" :class="{ open }" aria-label="Primary">
    <div class="nav-inner">
      <a href="#top" class="brand mono" @click="open = false">
        <span class="logo-mark" aria-hidden="true">{{ profile.initials }}</span>
        <span class="brand-name">{{ profile.handle }}</span>
      </a>

      <div class="nav-links" id="nav-links">
        <a
          v-for="l in navLinks"
          :key="l.id"
          :href="`#${l.id}`"
          :class="{ active: activeId === l.id }"
          :aria-current="activeId === l.id ? 'true' : undefined"
          @click="open = false"
        >{{ l.label }}</a>
      </div>

      <div class="nav-actions">
        <!-- Audi 4-Rings Interactive Audio / Track Button -->
        <button
          type="button"
          class="audi-nav-btn mono"
          :class="{ active: isPlaying }"
          :aria-label="isPlaying ? 'Pause WE ON GO' : 'Play WE ON GO'"
          :title="isPlaying ? 'Pause WE ON GO (BIA · Honorable C.N.O.T.E.)' : 'Play WE ON GO (BIA · Honorable C.N.O.T.E.)'"
          @click="togglePlay"
        >
          <svg viewBox="0 0 84 32" class="audi-nav-rings" aria-hidden="true">
            <circle class="ring r1" cx="16" cy="16" r="11" />
            <circle class="ring r2" cx="32" cy="16" r="11" />
            <circle class="ring r3" cx="48" cy="16" r="11" />
            <circle class="ring r4" cx="64" cy="16" r="11" />
          </svg>
          <span class="audio-tag">{{ profile.bgmTrack }}</span>
        </button>

        <a href="#contact" class="btn btn-p nav-cta" @click="open = false">Hire me</a>

        <button
          type="button"
          class="menu-btn"
          :aria-expanded="open"
          aria-controls="nav-links"
          aria-label="Toggle menu"
          @click="open = !open"
        >
          <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true">
            <path v-if="!open" d="M4 7h16M4 12h16M4 17h16" />
            <path v-else d="M6 6l12 12M18 6L6 18" />
          </svg>
        </button>
      </div>
    </div>
  </nav>
</template>

<style scoped>
.audi-nav-btn {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  height: 38px;
  padding: 0 14px 0 10px;
  border-radius: 999px;
  background: rgba(28, 18, 54, 0.7);
  border: 1.5px solid rgba(109, 40, 217, 0.45);
  color: var(--muted);
  font-size: 12px;
  cursor: pointer;
  transition: all 0.25s ease;
}

.audi-nav-btn:hover {
  background: rgba(109, 40, 217, 0.25);
  color: #fff;
  border-color: #a78bfa;
  transform: translateY(-1px);
  box-shadow: 0 0 16px rgba(109, 40, 217, 0.4);
}

.audi-nav-btn.active {
  background: rgba(109, 40, 217, 0.35);
  border-color: #c4b5fd;
  color: #ede4ff;
  box-shadow: 0 0 20px rgba(139, 92, 246, 0.5);
}

.audi-nav-rings {
  width: 44px;
  height: 18px;
  fill: none;
  stroke: #c4b5fd;
  stroke-width: 2.8;
  transition: stroke 0.2s;
}

.audi-nav-btn.active .audi-nav-rings {
  stroke: #ede4ff;
  filter: drop-shadow(0 0 6px rgba(196, 181, 253, 0.8));
}

.audi-nav-btn.active .ring {
  animation: nav-audi-wave 1.2s infinite ease-in-out alternate;
}

.audi-nav-btn.active .r1 { animation-delay: 0s; }
.audi-nav-btn.active .r2 { animation-delay: 0.2s; }
.audi-nav-btn.active .r3 { animation-delay: 0.4s; }
.audi-nav-btn.active .r4 { animation-delay: 0.6s; }

@keyframes nav-audi-wave {
  0% { transform: scale(1); stroke: #a78bfa; }
  100% { transform: scale(1.1); stroke: #38bdf8; }
}

@media (max-width: 680px) {
  .audio-tag {
    display: none;
  }
  .audi-nav-btn {
    padding: 0 8px;
  }
}
</style>
