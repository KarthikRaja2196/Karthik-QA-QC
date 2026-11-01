<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'

const isMuted = ref(false)
const isPlaying = ref(false)
const audioRef = ref<HTMLAudioElement | null>(null)

function startAudio() {
  if (!audioRef.value) return
  if (!isPlaying.value) {
    audioRef.value.volume = isMuted.value ? 0 : 0.45
    audioRef.value
      .play()
      .then(() => {
        isPlaying.value = true
        removeUserInteractionListeners()
      })
      .catch(() => {
        // Autoplay wait for user gesture
      })
  }
}

function toggleMute() {
  if (!audioRef.value) return
  isMuted.value = !isMuted.value
  audioRef.value.muted = isMuted.value
  if (!isPlaying.value && !isMuted.value) {
    startAudio()
  }
}

function onFirstUserGesture() {
  startAudio()
}

function removeUserInteractionListeners() {
  window.removeEventListener('click', onFirstUserGesture)
  window.removeEventListener('keydown', onFirstUserGesture)
  window.removeEventListener('touchstart', onFirstUserGesture)
}

onMounted(() => {
  // Try autoplay, and also attach first gesture listener
  startAudio()
  window.addEventListener('click', onFirstUserGesture, { once: true })
  window.addEventListener('keydown', onFirstUserGesture, { once: true })
  window.addEventListener('touchstart', onFirstUserGesture, { once: true })
})

onBeforeUnmount(() => {
  removeUserInteractionListeners()
  if (audioRef.value) {
    audioRef.value.pause()
  }
})
</script>

<template>
  <div class="bg-audio-container">
    <!-- Invisible background audio element -->
    <audio
      ref="audioRef"
      src="/audio/honourable.mp3"
      loop
      preload="auto"
    ></audio>

    <!-- Subtle, discreet sound toggle button (no track info, no tracking, no video) -->
    <button
      type="button"
      class="discreet-sound-btn"
      :class="{ muted: isMuted || !isPlaying }"
      :aria-label="isMuted ? 'Unmute background music' : 'Mute background music'"
      :title="isMuted ? 'Sound off — click to enable' : 'Sound on — click to mute'"
      @click="toggleMute"
    >
      <svg
        v-if="!isMuted && isPlaying"
        width="16"
        height="16"
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
        width="16"
        height="16"
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
    </button>
  </div>
</template>

<style scoped>
.bg-audio-container {
  position: fixed;
  bottom: 20px;
  right: 20px;
  z-index: 40;
}

.discreet-sound-btn {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: rgba(18, 10, 36, 0.7);
  border: 1px solid rgba(255, 255, 255, 0.12);
  backdrop-filter: blur(8px);
  color: var(--muted);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s ease;
  opacity: 0.65;
}

.discreet-sound-btn:hover {
  opacity: 1;
  color: #fff;
  border-color: rgba(167, 139, 250, 0.4);
  background: rgba(28, 18, 54, 0.9);
  transform: scale(1.08);
}

.discreet-sound-btn.muted {
  opacity: 0.45;
  color: #8c7ea8;
}
</style>
