<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'
import { navLinks, profile } from '../data/content'

defineProps<{ activeId: string }>()

const open = ref(false)

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
