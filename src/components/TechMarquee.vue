<script setup lang="ts">
defineProps<{ items: string[] }>()
</script>

<template>
  <div class="marquee-wrap">
    <div class="marquee mono" role="list" aria-label="Tech stack">
      <span
        v-for="(m, i) in [...items, ...items]"
        :key="i"
        class="marquee-item"
        role="listitem"
        :aria-hidden="i >= items.length ? 'true' : undefined"
      >{{ m }} <span class="spark" aria-hidden="true">✦</span></span>
    </div>
  </div>
</template>
