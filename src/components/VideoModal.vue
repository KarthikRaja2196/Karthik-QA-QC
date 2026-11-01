<script setup lang="ts">
import { onBeforeUnmount, onMounted } from 'vue'
import { useAudio } from '../composables/useAudio'
import { profile } from '../data/content'

const { isVideoModalOpen, closeVideoModal, play } = useAudio()

function onKeyDown(e: KeyboardEvent) {
  if (e.key === 'Escape' && isVideoModalOpen.value) {
    closeVideoModal()
  }
}

function switchToAudio() {
  closeVideoModal()
  play()
}

onMounted(() => {
  window.addEventListener('keydown', onKeyDown)
})

onBeforeUnmount(() => {
  window.removeEventListener('keydown', onKeyDown)
})
</script>

<template>
  <Teleport to="body">
    <Transition name="cinema-fade">
      <div
        v-if="isVideoModalOpen"
        class="video-modal-backdrop"
        role="dialog"
        aria-modal="true"
        aria-label="BIA - WE ON GO Official Video"
        @click.self="closeVideoModal"
      >
        <div class="video-modal-box">
          <!-- Modal Top Bar -->
          <div class="modal-top-bar">
            <div class="modal-track-info">
              <!-- Audi 4-ring badge -->
              <div class="audi-rings-icon" title="Audi-inspired Quad Pulse">
                <svg viewBox="0 0 84 32" width="46" height="18" fill="none" stroke="currentColor" stroke-width="2.8">
                  <circle cx="16" cy="16" r="11" />
                  <circle cx="32" cy="16" r="11" />
                  <circle cx="48" cy="16" r="11" />
                  <circle cx="64" cy="16" r="11" />
                </svg>
              </div>

              <div>
                <div class="modal-title mono">
                  <span class="live-dot"></span> BIA — WE ON GO
                </div>
                <div class="modal-sub mono">
                  Produced by Honorable C.N.O.T.E. · WE ON GO PACK
                </div>
              </div>
            </div>

            <div class="modal-actions">
              <button
                type="button"
                class="switch-audio-btn mono"
                title="Switch back to background audio mode"
                @click="switchToAudio"
              >
                🎵 Audio Only
              </button>
              <button
                type="button"
                class="close-modal-btn"
                aria-label="Close video modal"
                @click="closeVideoModal"
              >
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </button>
            </div>
          </div>

          <!-- 16:9 Video Embed Player -->
          <div class="video-embed-wrap">
            <iframe
              :src="`https://www.youtube-nocookie.com/embed/${profile.youtubeId}?autoplay=1&rel=0&modestbranding=1`"
              title="BIA - WE ON GO (Official Lyric Video)"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
              allowfullscreen
              class="video-iframe"
            ></iframe>
          </div>

          <!-- Modal Footer info -->
          <div class="modal-bottom-bar mono">
            <div class="meta-tags">
              <span class="pill-tag">BIA</span>
              <span class="pill-tag">Honorable C.N.O.T.E.</span>
              <span class="pill-tag">Official Video</span>
            </div>
            <div class="ext-links">
              <a
                href="https://www.jiosaavn.com/album/we-on-go-pack/Izs3nekZQNE_"
                target="_blank"
                rel="noopener noreferrer"
                class="stream-link"
              >
                JioSaavn Album ↗
              </a>
              <a
                :href="profile.videoUrl"
                target="_blank"
                rel="noopener noreferrer"
                class="stream-link"
              >
                YouTube ↗
              </a>
            </div>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<style scoped>
.video-modal-backdrop {
  position: fixed;
  inset: 0;
  z-index: 9999;
  background: rgba(10, 4, 20, 0.88);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}

.video-modal-box {
  width: 100%;
  max-width: 920px;
  background: #150c2c;
  border: 1.5px solid rgba(167, 139, 250, 0.4);
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 40px 120px -20px rgba(0, 0, 0, 0.9), 0 0 60px rgba(109, 40, 217, 0.35);
  animation: modal-pop 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

@keyframes modal-pop {
  from {
    opacity: 0;
    transform: scale(0.95) translateY(12px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.modal-top-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 24px;
  background: rgba(23, 14, 46, 0.95);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  gap: 16px;
}

.modal-track-info {
  display: flex;
  align-items: center;
  gap: 14px;
}

.audi-rings-icon {
  color: #c4b5fd;
  display: flex;
  align-items: center;
  filter: drop-shadow(0 0 8px rgba(167, 139, 250, 0.6));
}

.modal-title {
  font-size: 14px;
  font-weight: 700;
  color: #fff;
  display: flex;
  align-items: center;
  gap: 8px;
}

.live-dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: #ef4444;
  box-shadow: 0 0 10px #ef4444;
  animation: blink 1.2s infinite;
}

@keyframes blink {
  50% { opacity: 0.3; }
}

.modal-sub {
  font-size: 11.5px;
  color: var(--muted);
  margin-top: 2px;
}

.modal-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.switch-audio-btn {
  padding: 6px 14px;
  border-radius: 999px;
  background: rgba(109, 40, 217, 0.25);
  border: 1px solid rgba(167, 139, 250, 0.3);
  color: #e2d9f7;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.switch-audio-btn:hover {
  background: rgba(109, 40, 217, 0.5);
  color: #fff;
}

.close-modal-btn {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.close-modal-btn:hover {
  background: rgba(239, 68, 68, 0.2);
  border-color: #ef4444;
  color: #ef4444;
}

.video-embed-wrap {
  position: relative;
  width: 100%;
  padding-bottom: 56.25%; /* 16:9 Aspect Ratio */
  height: 0;
  background: #000;
}

.video-iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border: none;
}

.modal-bottom-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 24px;
  background: #100824;
  border-top: 1px solid rgba(255, 255, 255, 0.06);
  font-size: 11.5px;
}

.meta-tags {
  display: flex;
  gap: 8px;
}

.pill-tag {
  padding: 3px 8px;
  border-radius: 4px;
  background: rgba(255, 255, 255, 0.06);
  color: #c4b5fd;
}

.ext-links {
  display: flex;
  gap: 16px;
}

.stream-link {
  color: var(--muted);
  text-decoration: underline;
  transition: color 0.2s;
}

.stream-link:hover {
  color: #fff;
}

/* Cinema Fade Transition */
.cinema-fade-enter-active,
.cinema-fade-leave-active {
  transition: opacity 0.25s ease;
}

.cinema-fade-enter-from,
.cinema-fade-leave-to {
  opacity: 0;
}

@media (max-width: 600px) {
  .video-modal-backdrop {
    padding: 12px;
  }
  .modal-sub, .meta-tags {
    display: none;
  }
  .modal-top-bar {
    padding: 12px 16px;
  }
}
</style>
