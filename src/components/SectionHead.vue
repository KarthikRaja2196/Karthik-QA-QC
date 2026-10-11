<script setup lang="ts">
defineProps<{ num: string; label: string; title: string; desc: string }>()
</script>

<template>
  <div class="section-head reveal">
    <span class="mono tag">// {{ num }} — {{ label }}</span><span class="ghost" aria-hidden="true">{{ num }}</span>
    <h2 class="h2">{{ title }}</h2>
    <p>{{ desc }}</p>
  </div>
</template>
