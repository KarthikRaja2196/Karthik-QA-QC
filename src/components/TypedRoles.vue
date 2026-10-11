<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'

const props = defineProps<{ roles: string[] }>()

const display = ref(props.roles[0] ?? '')
let timer: ReturnType<typeof setInterval> | undefined
let roleIdx = 0
let chars = 0
let deleting = false
let hold = 0

// One step every 65ms: type forward, hold on the full word, delete, move to the next role.
function tick() {
  if (hold > 0) { hold--; return }
  const full = props.roles[roleIdx]
  if (!deleting) {
    if (chars < full.length) chars++
    else { deleting = true; hold = 26 }
  } else if (chars > 0) {
    chars--
  } else {
    deleting = false
    roleIdx = (roleIdx + 1) % props.roles.length
    hold = 4
  }
  display.value = props.roles[roleIdx].slice(0, chars)
}

onMounted(() => {
  // Reduced motion: leave the first role static rather than animating.
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return
  display.value = ''
  timer = setInterval(tick, 65)
})
onBeforeUnmount(() => clearInterval(timer))
</script>

<template>
  <span class="typed">{{ display }}</span><span class="caret" aria-hidden="true"></span>
</template>

<style scoped>
.typed { color: var(--text); }
</style>
