<script setup lang="ts">
import { ref } from 'vue'
import { useAudio } from '../composables/useAudio'

const {
  isPlaying,
  volume,
  isMuted,
  currentTime,
  duration,
  formattedCurrentTime,
  formattedDuration,
  trackName,
  trackSubtitle,
  isLooping,
  isExpanded,
  showAutoplayPrompt,
  isCustomFile,
  play,
  togglePlay,
  setVolume,
  toggleMute,
  seek,
  toggleLoop,
  toggleExpanded,
  loadCustomFile,
} = useAudio()

const fileInputRef = ref<HTMLInputElement | null>(null)

function onSeekInput(e: Event) {
  const val = Number((e.target as HTMLInputElement).value)
  seek(val)
}

function onVolumeInput(e: Event) {
  const val = Number((e.target as HTMLInputElement).value)
  setVolume(val)
}

function triggerFileUpload() {
  fileInputRef.value?.click()
}

function onFileSelected(e: Event) {
  const target = e.target as HTMLInputElement
  if (target.files && target.files[0]) {
    loadCustomFile(target.files[0])
  }
}
</script>

<template>
  <aside class="audio-player-wrap" aria-label="Background music player">
    <!-- Prompt toast for autoplay -->
    <Transition name="fade-slide">
      <div v-if="showAutoplayPrompt && !isPlaying" class="autoplay-toast" @click="play">
        <span class="music-icon">🎵</span>
        <div class="toast-text">
          <div class="toast-title">Background Music Ready</div>
          <div class="toast-sub">Click to listen to "Honourable"</div>
        </div>
        <button type="button" class="toast-btn" aria-label="Play music">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
            <polygon points="5 3 19 12 5 21 5 3"></polygon>
          </svg>
        </button>
      </div>
    </Transition>

    <!-- Hidden file input for custom song uploads -->
    <input
      ref="fileInputRef"
      type="file"
      accept="audio/*"
      class="sr-only"
      @change="onFileSelected"
    />

    <!-- Main Player Card / Dock -->
    <div
      class="player-dock"
      :class="{ expanded: isExpanded, playing: isPlaying }"
    >
      <!-- COMPACT / MINI MODE -->
      <div v-if="!isExpanded" class="mini-view">
        <button
          type="button"
          class="mini-disc"
          :class="{ spin: isPlaying }"
          :aria-label="isPlaying ? 'Pause Honourable' : 'Play Honourable'"
          @click="togglePlay"
        >
          <div class="disc-grooves">
            <span class="disc-core"></span>
          </div>
          <span class="play-indicator">
            <svg v-if="!isPlaying" width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
              <polygon points="5 3 19 12 5 21 5 3"></polygon>
            </svg>
            <svg v-else width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
              <rect x="6" y="4" width="4" height="16"></rect>
              <rect x="14" y="4" width="4" height="16"></rect>
            </svg>
          </span>
        </button>

        <div class="mini-info" @click="toggleExpanded">
          <div class="mini-title-row">
            <span class="track-tag mono">BGM</span>
            <span class="track-title" :title="trackName">{{ trackName }}</span>
          </div>
          <!-- Equalizer waves when playing -->
          <div class="eq-waves" :class="{ active: isPlaying }" aria-hidden="true">
            <span class="eq-bar b1"></span>
            <span class="eq-bar b2"></span>
            <span class="eq-bar b3"></span>
            <span class="eq-bar b4"></span>
            <span class="eq-bar b5"></span>
          </div>
        </div>

        <button
          type="button"
          class="mini-btn expand-btn"
          aria-label="Expand audio player"
          title="Open player controls"
          @click="toggleExpanded"
        >
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
            <path d="M15 3h6v6M9 21H3v-6M21 3l-7 7M3 21l7-7"></path>
          </svg>
        </button>
      </div>

      <!-- EXPANDED MODE -->
      <div v-else class="expanded-view">
        <div class="expanded-header">
          <div class="live-badge mono">
            <span class="pulse-dot" :class="{ live: isPlaying }"></span>
            {{ isPlaying ? 'PLAYING BACKGROUND MUSIC' : 'AUDIO PAUSED' }}
          </div>
          <button
            type="button"
            class="mini-btn close-btn"
            aria-label="Collapse audio player"
            @click="toggleExpanded"
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
              <path d="M4 14h6v6M20 10h-6V4M14 10l7-7M3 21l7-7"></path>
            </svg>
          </button>
        </div>

        <!-- Disc & Track Details -->
        <div class="track-hero">
          <div class="vinyl-wrap" :class="{ spin: isPlaying }">
            <div class="vinyl">
              <div class="vinyl-center">
                <span class="vinyl-badge mono">KR</span>
              </div>
            </div>
          </div>
          <div class="track-details">
            <h4 class="now-playing-title">{{ trackName }}</h4>
            <p class="now-playing-sub mono">{{ trackSubtitle }}</p>
            <div class="audio-source-pill mono">
              <span class="dot"></span>
              {{ isCustomFile ? 'Custom audio file' : 'Default portfolio soundtrack' }}
            </div>
          </div>
        </div>

        <!-- Waveform Visualizer -->
        <div class="visualizer" aria-hidden="true">
          <span
            v-for="i in 20"
            :key="i"
            class="v-bar"
            :class="{ active: isPlaying }"
            :style="{
              animationDelay: `${(i * 0.08) % 1.2}s`,
              animationDuration: `${0.8 + ((i % 5) * 0.15)}s`
            }"
          ></span>
        </div>

        <!-- Scrub Timeline -->
        <div class="timeline-row">
          <span class="time mono">{{ formattedCurrentTime }}</span>
          <div class="timeline-slider-wrap">
            <input
              type="range"
              min="0"
              :max="duration || 32"
              step="0.1"
              :value="currentTime"
              class="timeline-slider"
              aria-label="Audio timeline"
              @input="onSeekInput"
            />
          </div>
          <span class="time mono">{{ formattedDuration }}</span>
        </div>

        <!-- Controls Row -->
        <div class="expanded-controls">
          <button
            type="button"
            class="ctrl-btn"
            :class="{ active: isLooping }"
            :aria-label="isLooping ? 'Disable repeat' : 'Enable repeat'"
            title="Repeat track"
            @click="toggleLoop"
          >
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
              <path d="M17 2l4 4-4 4M3 11v-1a4 4 0 0 1 4-4h14M7 22l-4-4 4-4M21 13v1a4 4 0 0 1-4 4H3"></path>
            </svg>
          </button>

          <button
            type="button"
            class="ctrl-btn-play"
            :aria-label="isPlaying ? 'Pause' : 'Play'"
            @click="togglePlay"
          >
            <svg v-if="!isPlaying" width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
              <polygon points="5 3 19 12 5 21 5 3"></polygon>
            </svg>
            <svg v-else width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
              <rect x="6" y="4" width="4" height="16"></rect>
              <rect x="14" y="4" width="4" height="16"></rect>
            </svg>
          </button>

          <button
            type="button"
            class="ctrl-btn"
            :class="{ active: isMuted }"
            :aria-label="isMuted ? 'Unmute' : 'Mute'"
            title="Mute / Unmute"
            @click="toggleMute"
          >
            <svg v-if="!isMuted && volume > 0" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
              <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
              <path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"></path>
            </svg>
            <svg v-else width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
              <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
              <line x1="23" y1="9" x2="17" y2="15"></line>
              <line x1="17" y1="9" x2="23" y2="15"></line>
            </svg>
          </button>

          <div class="volume-slider-wrap">
            <input
              type="range"
              min="0"
              max="1"
              step="0.02"
              :value="isMuted ? 0 : volume"
              class="volume-slider"
              aria-label="Volume slider"
              @input="onVolumeInput"
            />
          </div>
        </div>

        <!-- Footer Action: Load Custom Track -->
        <div class="custom-track-bar">
          <button
            type="button"
            class="custom-upload-btn mono"
            @click="triggerFileUpload"
          >
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4M17 8l-5-5-5 5M12 3v12"></path>
            </svg>
            Load your own "Honourable" MP3
          </button>
        </div>
      </div>
    </div>
  </aside>
</template>

<style scoped>
.audio-player-wrap {
  position: fixed;
  bottom: 24px;
  right: 24px;
  z-index: 50;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 12px;
  pointer-events: none;
}

.autoplay-toast,
.player-dock {
  pointer-events: auto;
}

/* Autoplay Prompt Toast */
.autoplay-toast {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 16px;
  border-radius: 999px;
  background: rgba(28, 18, 54, 0.95);
  border: 1px solid rgba(167, 139, 250, 0.35);
  backdrop-filter: blur(14px);
  box-shadow: 0 12px 36px -8px rgba(109, 40, 217, 0.6);
  cursor: pointer;
  transition: transform 0.2s, border-color 0.2s;
}

.autoplay-toast:hover {
  transform: translateY(-2px);
  border-color: var(--accent);
}

.music-icon {
  font-size: 16px;
  animation: pulse-icon 1.8s infinite;
}

@keyframes pulse-icon {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.2); }
}

.toast-text {
  display: flex;
  flex-direction: column;
}

.toast-title {
  font-size: 12.5px;
  font-weight: 600;
  color: #fff;
}

.toast-sub {
  font-size: 11px;
  color: var(--muted);
}

.toast-btn {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: var(--accent);
  color: #fff;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

/* Player Dock */
.player-dock {
  background: rgba(23, 14, 46, 0.88);
  border: 1px solid rgba(109, 40, 217, 0.38);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  box-shadow: 0 20px 50px -15px rgba(0, 0, 0, 0.7), 0 0 24px -6px rgba(109, 40, 217, 0.4);
  border-radius: 999px;
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
  overflow: hidden;
}

.player-dock.expanded {
  width: 320px;
  border-radius: 24px;
  padding: 20px;
}

.player-dock.playing {
  border-color: rgba(167, 139, 250, 0.6);
  box-shadow: 0 24px 60px -15px rgba(0, 0, 0, 0.8), 0 0 32px -4px rgba(139, 92, 246, 0.5);
}

/* Mini View */
.mini-view {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 14px 8px 8px;
}

.mini-disc {
  position: relative;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  background: radial-gradient(circle, #38246d 0%, #160a2c 70%, #0d061a 100%);
  border: 1.5px solid rgba(167, 139, 250, 0.4);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  transition: transform 0.2s;
}

.mini-disc:hover {
  transform: scale(1.08);
}

.disc-grooves {
  position: absolute;
  inset: 4px;
  border-radius: 50%;
  border: 1px dashed rgba(255, 255, 255, 0.15);
}

.disc-core {
  position: absolute;
  inset: 10px;
  border-radius: 50%;
  background: var(--accent);
}

.play-indicator {
  position: relative;
  z-index: 2;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mini-disc.spin {
  animation: disc-rotate 4s linear infinite;
}

@keyframes disc-rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.mini-info {
  display: flex;
  flex-direction: column;
  gap: 3px;
  cursor: pointer;
  user-select: none;
}

.mini-title-row {
  display: flex;
  align-items: center;
  gap: 6px;
}

.track-tag {
  font-size: 9.5px;
  font-weight: 700;
  padding: 2px 5px;
  border-radius: 4px;
  background: rgba(109, 40, 217, 0.35);
  color: #c4b5fd;
}

.track-title {
  font-size: 13px;
  font-weight: 600;
  color: #f5f1ff;
  max-width: 110px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.eq-waves {
  display: flex;
  align-items: flex-end;
  gap: 2.5px;
  height: 10px;
}

.eq-bar {
  width: 2.5px;
  background: #a78bfa;
  border-radius: 1px;
  height: 3px;
  transition: height 0.2s;
}

.eq-waves.active .eq-bar {
  animation: eq-bounce 0.8s ease-in-out infinite alternate;
}

.eq-waves.active .b1 { animation-delay: 0.1s; }
.eq-waves.active .b2 { animation-delay: 0.3s; }
.eq-waves.active .b3 { animation-delay: 0.15s; }
.eq-waves.active .b4 { animation-delay: 0.4s; }
.eq-waves.active .b5 { animation-delay: 0.25s; }

@keyframes eq-bounce {
  0% { height: 2px; }
  100% { height: 10px; }
}

.mini-btn {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: transparent;
  border: 1px solid transparent;
  color: var(--muted);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.mini-btn:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.08);
}

/* Expanded View */
.expanded-view {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.expanded-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.live-badge {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 10px;
  letter-spacing: 0.05em;
  color: var(--muted);
}

.pulse-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #64748b;
}

.pulse-dot.live {
  background: #22c55e;
  box-shadow: 0 0 8px #22c55e;
  animation: live-blink 1.5s infinite;
}

@keyframes live-blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}

.track-hero {
  display: flex;
  align-items: center;
  gap: 16px;
}

.vinyl-wrap {
  width: 58px;
  height: 58px;
  border-radius: 50%;
  background: #0d061a;
  border: 2px solid rgba(167, 139, 250, 0.35);
  box-shadow: 0 0 16px rgba(109, 40, 217, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.vinyl-wrap.spin {
  animation: disc-rotate 5s linear infinite;
}

.vinyl {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: radial-gradient(circle, #2a1650 20%, #120a24 60%, #080410 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.vinyl-center {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: var(--accent);
  display: flex;
  align-items: center;
  justify-content: center;
}

.vinyl-badge {
  font-size: 9px;
  font-weight: 700;
  color: #fff;
}

.track-details {
  min-width: 0;
  flex: 1;
}

.now-playing-title {
  font-size: 16px;
  font-weight: 700;
  color: #fff;
  letter-spacing: -0.01em;
  margin: 0;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.now-playing-sub {
  font-size: 12px;
  color: var(--muted);
  margin-top: 2px;
}

.audio-source-pill {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  font-size: 10px;
  color: #c4b5fd;
  margin-top: 6px;
}

.audio-source-pill .dot {
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: var(--accent);
}

/* Visualizer */
.visualizer {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  height: 24px;
  padding: 0 4px;
  gap: 2px;
}

.v-bar {
  flex: 1;
  background: linear-gradient(to top, rgba(109, 40, 217, 0.4), #a78bfa);
  border-radius: 1px;
  height: 3px;
  transition: height 0.15s ease;
}

.v-bar.active {
  animation: bar-active 0.7s ease-in-out infinite alternate;
}

@keyframes bar-active {
  0% { height: 3px; }
  100% { height: 22px; }
}

/* Timeline */
.timeline-row {
  display: flex;
  align-items: center;
  gap: 10px;
}

.time {
  font-size: 11px;
  color: var(--muted);
  min-width: 28px;
}

.timeline-slider-wrap {
  flex: 1;
  display: flex;
  align-items: center;
}

.timeline-slider {
  width: 100%;
  height: 4px;
  -webkit-appearance: none;
  appearance: none;
  background: #2e1d54;
  border-radius: 2px;
  outline: none;
  cursor: pointer;
}

.timeline-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #f5f1ff;
  box-shadow: 0 0 8px var(--accent);
  cursor: pointer;
}

/* Controls */
.expanded-controls {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.ctrl-btn {
  width: 32px;
  height: 32px;
  border-radius: 8px;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.08);
  color: var(--muted);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.ctrl-btn:hover {
  color: #fff;
  border-color: rgba(255, 255, 255, 0.2);
}

.ctrl-btn.active {
  color: var(--accent-soft);
  border-color: var(--accent);
  background: rgba(109, 40, 217, 0.25);
}

.ctrl-btn-play {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: var(--accent);
  color: #fff;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 0 20px rgba(109, 40, 217, 0.6);
  transition: transform 0.2s, box-shadow 0.2s;
}

.ctrl-btn-play:hover {
  transform: scale(1.08);
  box-shadow: 0 0 28px rgba(139, 92, 246, 0.8);
}

.volume-slider-wrap {
  width: 70px;
}

.volume-slider {
  width: 100%;
  height: 4px;
  -webkit-appearance: none;
  appearance: none;
  background: #2e1d54;
  border-radius: 2px;
  outline: none;
  cursor: pointer;
}

.volume-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #c4b5fd;
  cursor: pointer;
}

/* Custom file button */
.custom-track-bar {
  border-top: 1px solid rgba(255, 255, 255, 0.08);
  padding-top: 12px;
  display: flex;
  justify-content: center;
}

.custom-upload-btn {
  background: transparent;
  border: 1px dashed rgba(167, 139, 250, 0.4);
  color: var(--muted);
  font-size: 11px;
  padding: 6px 12px;
  border-radius: 8px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s;
}

.custom-upload-btn:hover {
  border-color: var(--accent);
  color: #fff;
  background: rgba(109, 40, 217, 0.15);
}

/* Animations */
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.3s ease;
}

.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(10px);
}

@media (max-width: 480px) {
  .audio-player-wrap {
    bottom: 16px;
    right: 16px;
    left: 16px;
    align-items: stretch;
  }
  .player-dock.expanded {
    width: 100%;
  }
}
</style>
