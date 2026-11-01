import { ref, computed } from 'vue'

// Shared singleton reactive state for the audio & video player
const isPlaying = ref(false)
const volume = ref(0.7)
const isMuted = ref(false)
const currentTime = ref(0)
const duration = ref(134) // ~2m 14s standard duration for WE ON GO
const trackName = ref('WE ON GO')
const trackSubtitle = ref('BIA (Prod. by Honorable C.N.O.T.E.)')
const trackSrc = ref('/audio/honourable.mp3')
const isLooping = ref(true)
const isExpanded = ref(false)
const isVideoModalOpen = ref(false)
const hasInteracted = ref(false)
const showAutoplayPrompt = ref(false)
const isCustomFile = ref(false)

let audio: HTMLAudioElement | null = null

function initAudio() {
  if (typeof window === 'undefined') return
  if (!audio) {
    audio = new Audio(trackSrc.value)
    audio.loop = isLooping.value
    audio.volume = isMuted.value ? 0 : volume.value
    audio.preload = 'auto'

    audio.addEventListener('timeupdate', () => {
      if (audio) currentTime.value = audio.currentTime
    })

    audio.addEventListener('loadedmetadata', () => {
      if (audio && audio.duration && !isNaN(audio.duration)) {
        duration.value = audio.duration
      }
    })

    audio.addEventListener('play', () => {
      isPlaying.value = true
      hasInteracted.value = true
      showAutoplayPrompt.value = false
    })

    audio.addEventListener('pause', () => {
      isPlaying.value = false
    })

    audio.addEventListener('ended', () => {
      if (!isLooping.value) isPlaying.value = false
    })

    audio.addEventListener('error', (e) => {
      console.warn('Audio source fallback check:', e)
    })
  }
}

export function useAudio() {
  initAudio()

  async function play() {
    initAudio()
    if (!audio) return
    try {
      audio.volume = isMuted.value ? 0 : volume.value
      await audio.play()
      isPlaying.value = true
      hasInteracted.value = true
      showAutoplayPrompt.value = false
    } catch (err) {
      console.log('Autoplay deferred until user interaction:', err)
      showAutoplayPrompt.value = true
    }
  }

  function pause() {
    if (!audio) return
    audio.pause()
    isPlaying.value = false
  }

  function togglePlay() {
    if (isPlaying.value) {
      pause()
    } else {
      play()
    }
  }

  function setVolume(val: number) {
    volume.value = Math.max(0, Math.min(1, val))
    if (volume.value > 0) isMuted.value = false
    if (audio) {
      audio.volume = isMuted.value ? 0 : volume.value
    }
  }

  function toggleMute() {
    isMuted.value = !isMuted.value
    if (audio) {
      audio.volume = isMuted.value ? 0 : volume.value
    }
  }

  function seek(timeSec: number) {
    if (!audio) return
    const safeTime = Math.max(0, Math.min(duration.value, timeSec))
    audio.currentTime = safeTime
    currentTime.value = safeTime
  }

  function toggleLoop() {
    isLooping.value = !isLooping.value
    if (audio) audio.loop = isLooping.value
  }

  function toggleExpanded() {
    isExpanded.value = !isExpanded.value
  }

  function openVideoModal() {
    pause() // pause audio when opening video to prevent dual playback
    isVideoModalOpen.value = true
  }

  function closeVideoModal() {
    isVideoModalOpen.value = false
  }

  function toggleVideoModal() {
    if (isVideoModalOpen.value) {
      closeVideoModal()
    } else {
      openVideoModal()
    }
  }

  function loadCustomFile(file: File) {
    initAudio()
    if (!audio) return
    const url = URL.createObjectURL(file)
    trackName.value = file.name.replace(/\.[^/.]+$/, '')
    trackSubtitle.value = 'User Uploaded Audio'
    trackSrc.value = url
    isCustomFile.value = true
    audio.src = url
    audio.load()
    play()
  }

  const formattedCurrentTime = computed(() => formatTime(currentTime.value))
  const formattedDuration = computed(() => formatTime(duration.value))

  function formatTime(seconds: number): string {
    if (!seconds || isNaN(seconds)) return '0:00'
    const m = Math.floor(seconds / 60)
    const s = Math.floor(seconds % 60)
    return `${m}:${s < 10 ? '0' : ''}${s}`
  }

  return {
    isPlaying,
    volume,
    isMuted,
    currentTime,
    duration,
    formattedCurrentTime,
    formattedDuration,
    trackName,
    trackSubtitle,
    trackSrc,
    isLooping,
    isExpanded,
    isVideoModalOpen,
    hasInteracted,
    showAutoplayPrompt,
    isCustomFile,
    play,
    pause,
    togglePlay,
    setVolume,
    toggleMute,
    seek,
    toggleLoop,
    toggleExpanded,
    openVideoModal,
    closeVideoModal,
    toggleVideoModal,
    loadCustomFile,
  }
}
