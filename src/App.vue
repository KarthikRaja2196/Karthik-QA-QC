<script setup lang="ts">
import { computed, ref } from 'vue'
import NavBar from './components/NavBar.vue'
import QaBot from './components/QaBot.vue'
import TypedRoles from './components/TypedRoles.vue'
import TechMarquee from './components/TechMarquee.vue'
import TestRunCard from './components/TestRunCard.vue'
import SectionHead from './components/SectionHead.vue'
import ContactSection from './components/ContactSection.vue'
import CodeShowcase from './components/CodeShowcase.vue'
import RoiCalculator from './components/RoiCalculator.vue'
import AudioPlayer from './components/AudioPlayer.vue'
import { useActiveSection } from './composables/useScrollState'
import { useAudio } from './composables/useAudio'
import {
  navLinks, heroRoles, heroStats, techStack, skills, qualityGuarantees,
  services, projects, experienceMilestones, process, profile,
} from './data/content'

// Track active section for navbar highlighting
const { activeId } = useActiveSection([...navLinks.map((l) => l.id), 'contact'])

// Global Audio player state
const { isPlaying, togglePlay, trackName, openVideoModal } = useAudio()

// Pointer position over the hero, normalised to -1…1, drives the robot's head and eyes.
const look = ref({ x: 0, y: 0 })
const clamp = (n: number) => Math.max(-1, Math.min(1, n))

function onLook(e: PointerEvent) {
  if (e.pointerType === 'touch') return
  const r = (e.currentTarget as HTMLElement).getBoundingClientRect()
  look.value = {
    x: clamp(((e.clientX - r.left) / r.width) * 2 - 1),
    y: clamp(((e.clientY - r.top) / r.height) * 2 - 1),
  }
}
function onUnlook() {
  look.value = { x: 0, y: 0 }
}

// Interactive Skills Filter
const selectedCategory = ref<'all' | 'e2e' | 'api' | 'cicd'>('all')
const filteredSkills = computed(() => {
  if (selectedCategory.value === 'all') return skills
  return skills.filter((s) => s.category === selectedCategory.value || s.category === 'all')
})

// Mouse Spotlight dynamic position on cards
function onCardMove(e: PointerEvent) {
  const el = e.currentTarget as HTMLElement
  const r = el.getBoundingClientRect()
  el.style.setProperty('--mouse-x', `${e.clientX - r.left}px`)
  el.style.setProperty('--mouse-y', `${e.clientY - r.top}px`)
}
</script>

<template>
  <a href="#main" class="skip-link">Skip to content</a>
  <NavBar :active-id="activeId" />

  <!-- HERO SECTION -->
  <header id="top" class="hero" @pointermove="onLook" @pointerleave="onUnlook">
    <div class="grid-bg" aria-hidden="true"></div>
    <div class="glow g1" aria-hidden="true"></div>
    <div class="glow g2" aria-hidden="true"></div>
    <div class="scan" aria-hidden="true"></div>

    <div class="hero-grid">
      <div class="hero-copy">
        <div class="rise d1 status-row">
          <div class="mono status-pill">
            <span class="pulse"></span> Available for freelance projects
          </div>
          <!-- Audi 4-Rings BGM Audio Button -->
          <button
            type="button"
            class="hero-audi-pill mono"
            :class="{ active: isPlaying }"
            :title="isPlaying ? 'Pause WE ON GO (BIA · Honorable C.N.O.T.E.)' : 'Play WE ON GO (BIA · Honorable C.N.O.T.E.)'"
            @click="togglePlay"
          >
            <svg viewBox="0 0 84 32" class="audi-hero-rings" aria-hidden="true">
              <circle class="ring r1" cx="16" cy="16" r="11" />
              <circle class="ring r2" cx="32" cy="16" r="11" />
              <circle class="ring r3" cx="48" cy="16" r="11" />
              <circle class="ring r4" cx="64" cy="16" r="11" />
            </svg>
            <span class="song-title">{{ trackName }}</span>
            <span class="music-action">[{{ isPlaying ? 'Pause' : 'Play' }}]</span>
          </button>

          <!-- Watch Video Button -->
          <button
            type="button"
            class="hero-video-pill mono"
            title="Watch BIA - WE ON GO official lyric video"
            @click="openVideoModal"
          >
            🎬 Watch Video
          </button>
        </div>

        <h1 class="rise d2 h1">
          Test automation that <span class="hl">holds up</span> in production.
        </h1>

        <p class="rise d3 mono specialising">
          <span class="sr-only">Specialising in {{ heroRoles.join(', ') }}</span>
          <span aria-hidden="true">
            <span class="prompt">$</span> specialising in <TypedRoles :roles="heroRoles" />
          </span>
        </p>

        <p class="rise d4 lead">
          I'm {{ profile.name }} — a QA automation engineer with 8+ years of experience. I design and build end-to-end and API test
          frameworks with TypeScript + Playwright and Java + Selenium/TestNG, wired into your CI/CD
          pipeline with zero flakiness.
        </p>

        <div class="rise d5 hero-actions">
          <a href="#contact" class="btn btn-p btn-lg">Start a project <span aria-hidden="true">→</span></a>
          <a href="#projects" class="btn btn-o btn-lg">View case studies</a>
          <a href="#code" class="btn btn-o btn-lg">Inspect code</a>
        </div>

        <dl class="rise d5 hero-stats">
          <div v-for="s in heroStats" :key="s.label" class="stat">
            <dt>{{ s.label }}</dt>
            <dd>{{ s.value }}</dd>
          </div>
        </dl>
      </div>

      <div class="rise d3 hero-visual">
        <QaBot :mx="look.x" :my="look.y" />
        <div class="card-slot">
          <TestRunCard />
        </div>
      </div>
    </div>

    <TechMarquee :items="techStack" />
  </header>

  <main id="main">
    <!-- 01: SKILLS & TOOLBOX -->
    <section id="skills" class="sec container-1200">
      <SectionHead
        num="01"
        label="toolbox"
        title="Core automation skills"
        desc="A focused stack for shipping reliable automation — not chasing every new tool, but mastering the ones that hold up in production."
      />

      <!-- Category Filter Pills -->
      <div class="filter-bar mono">
        <button
          type="button"
          class="filter-pill"
          :class="{ active: selectedCategory === 'all' }"
          @click="selectedCategory = 'all'"
        >
          All Domains ({{ skills.length }})
        </button>
        <button
          type="button"
          class="filter-pill"
          :class="{ active: selectedCategory === 'e2e' }"
          @click="selectedCategory = 'e2e'"
        >
          🎭 End-to-End & Web
        </button>
        <button
          type="button"
          class="filter-pill"
          :class="{ active: selectedCategory === 'api' }"
          @click="selectedCategory = 'api'"
        >
          ⚡ API & Contracts
        </button>
        <button
          type="button"
          class="filter-pill"
          :class="{ active: selectedCategory === 'cicd' }"
          @click="selectedCategory = 'cicd'"
        >
          🚀 CI/CD & DevOps
        </button>
      </div>

      <div class="skills-grid">
        <article
          v-for="s in filteredSkills"
          :key="s.title"
          class="card spotlight-card reveal skill-card"
          @pointermove="onCardMove"
        >
          <div class="chip-ic mono" aria-hidden="true">{{ s.icon }}</div>
          <h3>{{ s.title }}</h3>
          <p>{{ s.desc }}</p>
          <ul class="tags">
            <li v-for="t in s.tags" :key="t" class="mono">{{ t }}</li>
          </ul>
          <div class="skill-level-badge mono">
            <span class="dot"></span> {{ s.level }}
          </div>
        </article>
      </div>
    </section>

    <!-- 02: CODE & FRAMEWORK ARCHITECTURE STANDARDS -->
    <section id="code" class="band">
      <div class="sec container-1200">
        <SectionHead
          num="02"
          label="engineering standards"
          title="Clean, maintainable test architecture"
          desc="Test suites shouldn't be fragile scripts. I build reusable Page Object Models, custom fixtures, thread-safe runners, and CI matrix workflows."
        />
        <CodeShowcase />
      </div>
    </section>

    <!-- 03: SERVICES & QUALITY GUARANTEES -->
    <section id="services" class="sec container-1200">
      <div class="two">
        <SectionHead
          class="sticky-head"
          num="03"
          label="services"
          title="What I can do for your team"
          desc="Fixed-scope or ongoing engagements — from a first automation framework to stabilizing an existing flaky suite."
        />
        <div class="service-list">
          <article
            v-for="v in services"
            :key="v.num"
            class="card spotlight-card reveal service-card"
            @pointermove="onCardMove"
          >
            <div class="mono service-num">{{ v.num }}</div>
            <div>
              <h3>{{ v.title }}</h3>
              <ul>
                <li v-for="it in v.items" :key="it">
                  <span class="mono" aria-hidden="true">→</span>{{ it }}
                </li>
              </ul>
            </div>
          </article>
        </div>
      </div>

      <!-- 4 Pillars of Quality Guarantees -->
      <div class="guarantees-grid">
        <article
          v-for="g in qualityGuarantees"
          :key="g.title"
          class="card spotlight-card reveal guarantee-card"
          @pointermove="onCardMove"
        >
          <div class="guarantee-icon" aria-hidden="true">{{ g.icon }}</div>
          <h3>{{ g.title }}</h3>
          <p>{{ g.desc }}</p>
        </article>
      </div>
    </section>

    <!-- 04: CASE STUDIES & PROJECTS -->
    <section id="projects" class="band">
      <div class="sec container-1200">
        <SectionHead
          num="04"
          label="case studies"
          title="Recent work & production results"
          desc="Representative automation frameworks and metrics achieved for high-throughput applications."
        />
        <div class="project-list">
          <article
            v-for="(p, i) in projects"
            :key="p.title"
            class="card spotlight-card proj reveal"
            @pointermove="onCardMove"
          >
            <div>
              <div class="mono proj-meta">
                <span>{{ String(i + 1).padStart(2, '0') }} · {{ p.role }}</span>
                <span class="proj-arrow" aria-hidden="true">↗</span>
              </div>
              <h3>{{ p.title }}</h3>
              <p>{{ p.desc }}</p>
              <ul class="tags">
                <li v-for="st in p.stack" :key="st" class="mono">{{ st }}</li>
              </ul>
            </div>
            <dl class="metrics">
              <div v-for="m in p.metrics" :key="m.label">
                <dt>{{ m.label }}</dt>
                <dd>{{ m.value }}</dd>
              </div>
            </dl>
          </article>
        </div>
      </div>
    </section>

    <!-- 05: INTERACTIVE QA ROI ESTIMATOR -->
    <section id="calculator" class="sec container-1200">
      <SectionHead
        num="05"
        label="business value"
        title="Estimate your regression savings"
        desc="See the tangible reduction in cycle time and engineering costs when automating manual regression."
      />
      <RoiCalculator />
    </section>

    <!-- 06: PROCESS & WORK HISTORY TIMELINE -->
    <section id="process" class="band">
      <div class="sec container-1200">
        <SectionHead
          num="06"
          label="how we'll work"
          title="A simple, transparent process"
          desc="No surprises — you'll know the plan, the stack and the timeline before any code is written."
        />
        <div class="process-wrap">
          <div class="track" aria-hidden="true"></div>
          <ol class="process-grid">
            <li v-for="st in process" :key="st.no" class="reveal">
              <div class="mono step-no">{{ st.no }}</div>
              <h3>{{ st.title }}</h3>
              <p>{{ st.desc }}</p>
            </li>
          </ol>
        </div>

        <!-- 8+ Years Experience Timeline -->
        <div class="timeline-wrap">
          <h3 class="mono tag" style="color: var(--accent-soft); font-size: 14px; margin-top: 40px;">
            // CAREER TRACK RECORD & MILESTONES
          </h3>
          <article
            v-for="m in experienceMilestones"
            :key="m.period"
            class="card spotlight-card reveal timeline-card"
            @pointermove="onCardMove"
          >
            <div class="timeline-period mono">
              <span>{{ m.period }}</span>
              <span class="timeline-scope">{{ m.scope }}</span>
            </div>
            <div class="timeline-content">
              <h3>{{ m.role }}</h3>
              <p class="timeline-desc">{{ m.desc }}</p>
              <ul class="timeline-highlights mono">
                <li v-for="h in m.highlights" :key="h">
                  <span>✓</span> {{ h }}
                </li>
              </ul>
            </div>
          </article>
        </div>
      </div>
    </section>

    <!-- 07: CONTACT SECTION -->
    <ContactSection />
  </main>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="mono footer-inner">
      <span>© {{ new Date().getFullYear() }} {{ profile.name }} · {{ profile.location }}</span>
      <div class="footer-meta">
        <span>BGM: {{ trackName }}</span>
        <span>·</span>
        <span>Built with Vue 3 & Vite · Tested with Playwright</span>
      </div>
    </div>
  </footer>

  <!-- FLOATING AUDIO PLAYER (HONOURABLE) -->
  <AudioPlayer />
</template>

<style scoped>
.status-row {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 12px;
}

.music-action {
  color: var(--accent-soft);
  font-weight: 700;
}

.hero-audi-pill {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 6px 14px 6px 10px;
  border-radius: 999px;
  background: rgba(28, 18, 54, 0.75);
  border: 1.5px solid rgba(167, 139, 250, 0.4);
  font-size: 12.5px;
  color: #e2d9f7;
  cursor: pointer;
  transition: all 0.25s ease;
}

.hero-audi-pill:hover {
  background: rgba(109, 40, 217, 0.3);
  border-color: #a78bfa;
  transform: translateY(-2px);
  box-shadow: 0 0 20px rgba(109, 40, 217, 0.5);
}

.hero-audi-pill.active {
  background: rgba(109, 40, 217, 0.38);
  border-color: #c4b5fd;
  color: #fff;
  box-shadow: 0 0 24px rgba(139, 92, 246, 0.6);
}

.audi-hero-rings {
  width: 44px;
  height: 18px;
  fill: none;
  stroke: #c4b5fd;
  stroke-width: 2.8;
  filter: drop-shadow(0 0 4px rgba(167, 139, 250, 0.5));
}

.hero-audi-pill.active .audi-hero-rings {
  stroke: #ede4ff;
  filter: drop-shadow(0 0 8px rgba(196, 181, 253, 0.9));
}

.hero-audi-pill.active .ring {
  animation: hero-ring-wave 1.3s infinite ease-in-out alternate;
}

.hero-audi-pill.active .r1 { animation-delay: 0s; }
.hero-audi-pill.active .r2 { animation-delay: 0.2s; }
.hero-audi-pill.active .r3 { animation-delay: 0.4s; }
.hero-audi-pill.active .r4 { animation-delay: 0.6s; }

@keyframes hero-ring-wave {
  0% { transform: scale(1); stroke: #a78bfa; }
  100% { transform: scale(1.1); stroke: #38bdf8; }
}

.hero-video-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 14px;
  border-radius: 999px;
  background: rgba(239, 68, 68, 0.2);
  border: 1.5px solid rgba(239, 68, 68, 0.45);
  font-size: 12.5px;
  color: #fff;
  cursor: pointer;
  transition: all 0.25s ease;
}

.hero-video-pill:hover {
  background: #ef4444;
  box-shadow: 0 0 22px rgba(239, 68, 68, 0.6);
  transform: translateY(-2px);
}

.footer-meta {
  display: flex;
  align-items: center;
  gap: 10px;
}
</style>
