<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'

const isPlaying = ref(false)
const isMuted = ref(false)
const needInteraction = ref(true)
const audioRef = ref<HTMLAudioElement | null>(null)

async function tryPlay() {
  if (!audioRef.value) return
  try {
    audioRef.value.volume = isMuted.value ? 0 : 0.5
    await audioRef.value.play()
    isPlaying.value = true
    needInteraction.value = false
    removeListeners()
  } catch (err) {
    // Autoplay blocked by external browser policy until user interacts
    isPlaying.value = false
    needInteraction.value = true
  }
}

function handleInteraction() {
  if (!isPlaying.value) {
    tryPlay()
  }
}

function toggleSound() {
  if (!audioRef.value) return
  if (!isPlaying.value) {
    // Direct user click - guaranteed by browser to allow playback
    isMuted.value = false
    audioRef.value.muted = false
    tryPlay()
  } else {
    // Toggle mute
    isMuted.value = !isMuted.value
    audioRef.value.muted = isMuted.value
  }
}

const events = ['pointerdown', 'mousedown', 'touchstart', 'touchend', 'keydown', 'click']

function attachListeners() {
  if (typeof window === 'undefined') return
  events.forEach((evt) => {
    document.addEventListener(evt, handleInteraction, { capture: true, once: true })
  })
}

function removeListeners() {
  if (typeof window === 'undefined') return
  events.forEach((evt) => {
    document.removeEventListener(evt, handleInteraction, { capture: true })
  })
}

onMounted(() => {
  // 1. Attempt immediate play (will succeed if user previously interacted or browser allows)
  tryPlay()

  // 2. Attach capture listeners for any touch, click, key, or tap
  attachListeners()
})

onBeforeUnmount(() => {
  removeListeners()
  if (audioRef.value) {
    audioRef.value.pause()
  }
})
</script>

<template>
  <div class="bg-sound-container">
    <!-- Background Audio Element -->
    <audio
      ref="audioRef"
      src="/audio/honourable.mp3"
      loop
      preload="auto"
      playsinline
    ></audio>

    <!-- Floating Sound Pill: prompts visitor if browser blocked autoplay, or lets them mute -->
    <button
      type="button"
      class="sound-pill mono"
      :class="{
        'needs-tap': needInteraction && !isPlaying,
        'playing': isPlaying && !isMuted,
        'muted': isMuted
      }"
      :aria-label="isPlaying && !isMuted ? 'Mute sound' : 'Enable sound'"
      @click.stop="toggleSound"
    >
      <span class="sound-icon" aria-hidden="true">
        <svg
          v-if="isPlaying && !isMuted"
          width="15"
          height="15"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
          <path d="M15.54 8.46a5 5 0 0 1 0 7.07"></path>
          <path d="M19.07 4.93a10 10 0 0 1 0 14.14"></path>
        </svg>
        <svg
          v-else
          width="15"
          height="15"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
          <line x1="23" y1="9" x2="17" y2="15"></line>
          <line x1="17" y1="9" x2="23" y2="15"></line>
        </svg>
      </span>

      <span class="sound-text">
        <template v-if="needInteraction && !isPlaying">
          🔊 Tap to Play Sound
        </template>
        <template v-else-if="isPlaying && !isMuted">
          Sound: On
        </template>
        <template v-else>
          Sound: Muted
        </template>
      </span>
    </button>
  </div>
</template>

<style scoped>
.bg-sound-container {
  position: fixed;
  bottom: 22px;
  right: 22px;
  z-index: 999;
}

.sound-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  height: 38px;
  padding: 0 14px;
  border-radius: 999px;
  background: rgba(23, 14, 46, 0.88);
  border: 1px solid rgba(167, 139, 250, 0.35);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  color: #ede4ff;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.25s ease;
  box-shadow: 0 8px 24px -4px rgba(0, 0, 0, 0.6);
}

.sound-pill:hover {
  transform: translateY(-2px);
  border-color: #a78bfa;
  background: rgba(36, 23, 63, 0.95);
  box-shadow: 0 12px 30px -4px rgba(109, 40, 217, 0.5);
}

/* Pulsing highlight when waiting for external browser interaction */
.sound-pill.needs-tap {
  background: rgba(109, 40, 217, 0.85);
  border-color: #c4b5fd;
  color: #fff;
  box-shadow: 0 0 20px rgba(139, 92, 246, 0.6);
  animation: tap-pulse 2s infinite ease-in-out;
}

@keyframes tap-pulse {
  0%, 100% {
    transform: scale(1);
    box-shadow: 0 0 16px rgba(109, 40, 217, 0.5);
  }
  50% {
    transform: scale(1.05);
    box-shadow: 0 0 28px rgba(167, 139, 250, 0.8);
  }
}

.sound-pill.muted {
  opacity: 0.6;
  color: var(--muted);
  border-color: rgba(255, 255, 255, 0.12);
}

.sound-icon {
  display: flex;
  align-items: center;
  justify-content: center;
}

.sound-text {
  letter-spacing: 0.02em;
}

@media (max-width: 480px) {
  .bg-sound-container {
    bottom: 16px;
    right: 16px;
  }
}
</style>
