<script setup lang="ts">
import { profile } from '../data/content'
</script>

<template>
  <section id="contact" class="sec container-1200">
    <div class="big-cta reveal">
      <span class="mono cta-tag">// 05 — let's talk</span><span class="ghost" aria-hidden="true">05</span>
      <div class="orbit" aria-hidden="true"><span></span></div>
      <h2 class="h2 cta-title">Ship releases with a suite you can trust.</h2>
      <p class="cta-copy">Tell me about your app and your current QA gaps — I'll reply with a framework plan and timeline.</p>
      <div class="cta-actions">
        <a :href="`mailto:${profile.email}`" class="btn cta-btn cta-dark">{{ profile.email }} <span aria-hidden="true">→</span></a>
        <a :href="profile.phoneHref" class="btn cta-btn cta-ghost">{{ profile.phone }}</a>
      </div>
    </div>
  </section>
</template>
