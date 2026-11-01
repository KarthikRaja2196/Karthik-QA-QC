<script setup lang="ts">
import { ref } from 'vue'
import { profile } from '../data/content'

const copied = ref(false)

async function copyEmail() {
  try {
    await navigator.clipboard.writeText(profile.email)
    copied.value = true
    setTimeout(() => {
      copied.value = false
    }, 2500)
  } catch (e) {
    console.warn('Failed to copy email:', e)
  }
}

const inquiryTopics = [
  'Playwright Framework from Scratch',
  'Fix & Stabilize Flaky Tests',
  'CI/CD GitHub Actions Sharding',
  'REST API Automation Suite',
]
</script>

<template>
  <section id="contact" class="sec container-1200">
    <div class="big-cta reveal">
      <span class="mono cta-tag">// 06 — let's connect</span>
      <span class="ghost" aria-hidden="true">06</span>
      <div class="orbit" aria-hidden="true"><span></span></div>

      <div class="availability-badge mono">
        <span class="status-indicator"></span>
        {{ profile.availability }}
      </div>

      <h2 class="h2 cta-title">Ship releases with a suite you can trust.</h2>
      <p class="cta-copy">
        Whether you need a brand new Playwright framework, CI/CD parallel execution, or stabilization of a flaky suite — let's discuss your timeline.
      </p>

      <!-- Quick Topic Chips -->
      <div class="topic-suggestions">
        <span class="topic-hint mono">Quick topics:</span>
        <div class="topic-chips">
          <a
            v-for="topic in inquiryTopics"
            :key="topic"
            :href="`mailto:${profile.email}?subject=${encodeURIComponent('Inquiry: ' + topic)}`"
            class="topic-chip mono"
          >
            + {{ topic }}
          </a>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="cta-actions">
        <a :href="`mailto:${profile.email}`" class="btn cta-btn cta-dark">
          {{ profile.email }}
          <span aria-hidden="true">→</span>
        </a>

        <button
          type="button"
          class="btn cta-btn cta-ghost copy-cta-btn mono"
          @click="copyEmail"
        >
          <span v-if="!copied">📋 Copy Email</span>
          <span v-else class="copied-badge">✓ Copied to clipboard!</span>
        </button>

        <a :href="profile.whatsappHref" target="_blank" rel="noopener noreferrer" class="btn cta-btn cta-wa mono">
          <span>💬 WhatsApp</span>
        </a>

        <a :href="profile.phoneHref" class="btn cta-btn cta-ghost mono">
          {{ profile.phone }}
        </a>
      </div>

      <div class="cta-meta mono">
        <span>📍 {{ profile.location }}</span>
        <span>•</span>
        <span>⚡ Typically replies within 2 hours</span>
      </div>
    </div>
  </section>
</template>

<style scoped>
.availability-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 14px;
  border-radius: 999px;
  background: rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.2);
  font-size: 12.5px;
  color: #f1e8ff;
  width: fit-content;
}

.status-indicator {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #34d399;
  box-shadow: 0 0 10px #34d399;
  animation: pulse-status 2s infinite;
}

@keyframes pulse-status {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.5; transform: scale(0.9); }
}

.topic-suggestions {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: 4px;
}

.topic-hint {
  font-size: 12px;
  color: #e2d4fc;
}

.topic-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.topic-chip {
  font-size: 12px;
  padding: 6px 14px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  border: 1px solid rgba(255, 255, 255, 0.25);
  color: #fff;
  transition: all 0.2s;
}

.topic-chip:hover {
  background: #fff;
  color: var(--accent);
  border-color: #fff;
  transform: translateY(-2px);
}

.copy-cta-btn {
  cursor: pointer;
  background: transparent;
}

.copied-badge {
  color: #34d399;
  font-weight: 700;
}

.cta-wa {
  background: rgba(37, 211, 102, 0.2);
  border: 1.5px solid #25d366;
  color: #fff;
}

.cta-wa:hover {
  background: #25d366;
  color: #0d061a;
  box-shadow: 0 0 24px rgba(37, 211, 102, 0.5);
}

.cta-meta {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 12px;
  font-size: 12.5px;
  color: #e2d4fc;
  margin-top: 6px;
}
</style>
