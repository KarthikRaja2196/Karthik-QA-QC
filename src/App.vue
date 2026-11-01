<script setup lang="ts">
import { computed, ref } from 'vue'
import NavBar from './components/NavBar.vue'
import TechHandOrbit from './components/TechHandOrbit.vue'
import TypedRoles from './components/TypedRoles.vue'
import TechMarquee from './components/TechMarquee.vue'
import TestRunCard from './components/TestRunCard.vue'
import SectionHead from './components/SectionHead.vue'
import ContactSection from './components/ContactSection.vue'
import CodeShowcase from './components/CodeShowcase.vue'
import RoiCalculator from './components/RoiCalculator.vue'
import BackgroundAudio from './components/BackgroundAudio.vue'
import NeuralBackground from './components/NeuralBackground.vue'
import { useActiveSection } from './composables/useScrollState'
import {
  navLinks, heroRoles, heroStats, techStack, skills, qualityGuarantees,
  aiCapabilities, services, projects, experienceMilestones, process, profile,
} from './data/content'

// Track active section for navbar highlighting
const { activeId } = useActiveSection([...navLinks.map((l) => l.id), 'contact'])

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

  <!-- HERO SECTION WITH NEURAL AI CANVAS -->
  <header id="top" class="hero" @pointermove="onLook" @pointerleave="onUnlook">
    <NeuralBackground />
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
          <!-- Futuristic AI Badge -->
          <div class="mono ai-badge">
            <span class="ai-spark">✦</span> AI-Augmented QA & Self-Healing
          </div>
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
          frameworks with TypeScript + Playwright and Java + Selenium/TestNG, augmented with self-healing AI agents
          and automated CI/CD pipelines.
        </p>

        <div class="rise d5 hero-actions">
          <a href="#contact" class="btn btn-p btn-lg">Start a project <span aria-hidden="true">→</span></a>
          <a href="#projects" class="btn btn-o btn-lg">View case studies</a>
          <a href="#ai" class="btn btn-o btn-lg">AI Capabilities</a>
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
        <TechHandOrbit :mx="look.x" :my="look.y" />
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

    <!-- 02: AI QA CAPABILITIES & SELF-HEALING -->
    <section id="ai" class="band ai-section">
      <div class="sec container-1200">
        <SectionHead
          num="02"
          label="artificial intelligence"
          title="Next-gen AI testing & self-healing"
          desc="Modern applications move too fast for brittle scripts. I integrate AI neural embeddings, visual inspection, and LLM edge-case synthesis into production suites."
        />
        <div class="ai-grid">
          <article
            v-for="c in aiCapabilities"
            :key="c.title"
            class="card spotlight-card ai-card reveal"
            @pointermove="onCardMove"
          >
            <div class="ai-card-top">
              <span class="ai-card-icon" aria-hidden="true">{{ c.icon }}</span>
              <span class="mono ai-card-tag">{{ c.tag }}</span>
            </div>
            <h3>{{ c.title }}</h3>
            <p>{{ c.desc }}</p>
            <div class="ai-card-metric mono">
              <span class="metric-dot"></span> {{ c.metric }}
            </div>
          </article>
        </div>
      </div>
    </section>

    <!-- 03: CODE & FRAMEWORK ARCHITECTURE STANDARDS -->
    <section id="code" class="sec container-1200">
      <SectionHead
        num="03"
        label="engineering standards"
        title="Clean, maintainable test architecture"
        desc="Test suites shouldn't be fragile scripts. I build reusable Page Object Models, custom fixtures, thread-safe runners, and CI matrix workflows."
      />
      <CodeShowcase />
    </section>

    <!-- 04: SERVICES & QUALITY GUARANTEES -->
    <section id="services" class="band">
      <div class="sec container-1200">
        <div class="two">
          <SectionHead
            class="sticky-head"
            num="04"
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
      </div>
    </section>

    <!-- 05: CASE STUDIES & PROJECTS -->
    <section id="projects" class="sec container-1200">
      <SectionHead
        num="05"
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
    </section>

    <!-- 06: INTERACTIVE QA ROI ESTIMATOR -->
    <section id="calculator" class="band">
      <div class="sec container-1200">
        <SectionHead
          num="06"
          label="business value"
          title="Estimate your regression savings"
          desc="See the tangible reduction in cycle time and engineering costs when automating manual regression."
        />
        <RoiCalculator />
      </div>
    </section>

    <!-- 07: PROCESS & WORK HISTORY TIMELINE -->
    <section id="process" class="sec container-1200">
      <SectionHead
        num="07"
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

      <!-- 6+ Years Industry Experience Timeline (Graduated 2018 — Present) -->
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
    </section>

    <!-- 08: CONTACT SECTION -->
    <ContactSection />
  </main>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="mono footer-inner">
      <span>© {{ new Date().getFullYear() }} {{ profile.name }} · {{ profile.location }}</span>
      <span>Built with Vue 3 & Vite · Tested with Playwright</span>
    </div>
  </footer>

  <!-- DISCREET BACKGROUND AUDIO -->
  <BackgroundAudio />
</template>

<style scoped>
.status-row {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 12px;
}
</style>
