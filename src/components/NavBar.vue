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
        <!-- Audio BGM Toggle in Header -->
        <button
          type="button"
          class="audio-nav-btn mono"
          :class="{ active: isPlaying }"
          :aria-label="isPlaying ? 'Pause Honourable background music' : 'Play Honourable background music'"
          :title="isPlaying ? 'Pause background music (Honourable)' : 'Play background music (Honourable)'"
          @click="togglePlay"
        >
          <span class="eq-nav-bars" :class="{ running: isPlaying }" aria-hidden="true">
            <span class="nb-1"></span>
            <span class="nb-2"></span>
            <span class="nb-3"></span>
          </span>
          <span class="audio-tag">Honourable</span>
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
.audio-nav-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  height: 38px;
  padding: 0 12px;
  border-radius: 999px;
  background: rgba(28, 18, 54, 0.6);
  border: 1px solid rgba(109, 40, 217, 0.4);
  color: var(--muted);
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.audio-nav-btn:hover {
  background: rgba(109, 40, 217, 0.2);
  color: #fff;
  border-color: var(--accent);
}

.audio-nav-btn.active {
  background: rgba(109, 40, 217, 0.28);
  border-color: #a78bfa;
  color: #ede4ff;
  box-shadow: 0 0 14px rgba(109, 40, 217, 0.4);
}

.eq-nav-bars {
  display: inline-flex;
  align-items: flex-end;
  gap: 2px;
  height: 12px;
}

.eq-nav-bars span {
  width: 2.5px;
  background: currentColor;
  border-radius: 1px;
  height: 3px;
  transition: height 0.2s;
}

.eq-nav-bars.running .nb-1 {
  animation: nav-bar 0.7s infinite alternate ease-in-out;
}
.eq-nav-bars.running .nb-2 {
  animation: nav-bar 0.9s infinite alternate ease-in-out 0.2s;
}
.eq-nav-bars.running .nb-3 {
  animation: nav-bar 0.6s infinite alternate ease-in-out 0.4s;
}

@keyframes nav-bar {
  0% { height: 3px; }
  100% { height: 12px; }
}

@media (max-width: 640px) {
  .audio-tag {
    display: none;
  }
  .audio-nav-btn {
    padding: 0 9px;
  }
}
</style>
