<script setup lang="ts">
import { ref } from 'vue'
import NavBar from './components/NavBar.vue'
import QaBot from './components/QaBot.vue'
import TypedRoles from './components/TypedRoles.vue'
import TechMarquee from './components/TechMarquee.vue'
import TestRunCard from './components/TestRunCard.vue'
import SectionHead from './components/SectionHead.vue'
import ContactSection from './components/ContactSection.vue'
import { useActiveSection } from './composables/useScrollState'
import {
  navLinks, heroRoles, heroStats, techStack, skills, services, projects, process, profile,
} from './data/content'

// 'contact' is tracked too (it has no nav link) so "Process" un-highlights once you scroll past it.
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
</script>

<template>
  <a href="#main" class="skip-link">Skip to content</a>
  <NavBar :active-id="activeId" />

  <header id="top" class="hero" @pointermove="onLook" @pointerleave="onUnlook">
    <div class="grid-bg" aria-hidden="true"></div>
    <div class="glow g1" aria-hidden="true"></div>
    <div class="glow g2" aria-hidden="true"></div>
    <div class="scan" aria-hidden="true"></div>

    <div class="hero-grid">
      <div class="hero-copy">
        <div class="rise d1 mono status-pill"><span class="pulse"></span> Available for freelance projects</div>
        <h1 class="rise d2 h1">Test automation that <span class="hl">holds up</span> in production.</h1>
        <p class="rise d3 mono specialising">
          <span class="sr-only">Specialising in {{ heroRoles.join(', ') }}</span>
          <span aria-hidden="true"><span class="prompt">$</span> specialising in <TypedRoles :roles="heroRoles" /></span>
        </p>
        <p class="rise d4 lead">
          I'm {{ profile.name }} — a QA automation engineer. I design and build end-to-end and API test
          frameworks with TypeScript + Playwright and Java + Selenium/TestNG, wired into your CI/CD
          pipeline, with clean architecture your team can maintain.
        </p>
        <div class="rise d5 hero-actions">
          <a href="#contact" class="btn btn-p btn-lg">Start a project <span aria-hidden="true">→</span></a>
          <a href="#projects" class="btn btn-o btn-lg">View case studies</a>
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
        <div class="card-slot"><TestRunCard /></div>
      </div>
    </div>

    <TechMarquee :items="techStack" />
  </header>

  <main id="main">
    <section id="skills" class="sec container-1200">
      <SectionHead
        num="01" label="toolbox" title="Core automation skills"
        desc="A focused stack for shipping reliable automation — not chasing every new tool, but mastering the ones that hold up in production."
      />
      <div class="skills-grid">
        <article v-for="s in skills" :key="s.title" class="card reveal skill-card">
          <div class="chip-ic mono" aria-hidden="true">{{ s.icon }}</div>
          <h3>{{ s.title }}</h3>
          <p>{{ s.desc }}</p>
          <ul class="tags">
            <li v-for="t in s.tags" :key="t" class="mono">{{ t }}</li>
          </ul>
        </article>
      </div>
    </section>

    <section id="services" class="band">
      <div class="sec container-1200">
        <div class="two">
          <SectionHead
            class="sticky-head" num="02" label="services" title="What I can do for your team"
            desc="Fixed-scope or ongoing engagements — from a first automation framework to stabilising an existing flaky suite."
          />
          <div class="service-list">
            <article v-for="v in services" :key="v.num" class="card reveal service-card">
              <div class="mono service-num">{{ v.num }}</div>
              <div>
                <h3>{{ v.title }}</h3>
                <ul>
                  <li v-for="it in v.items" :key="it"><span class="mono" aria-hidden="true">→</span>{{ it }}</li>
                </ul>
              </div>
            </article>
          </div>
        </div>
      </div>
    </section>

    <section id="projects" class="sec container-1200">
      <SectionHead
        num="03" label="case studies" title="Recent work"
        desc="Representative automation frameworks and results. Client names withheld — details available on request."
      />
      <div class="project-list">
        <article v-for="(p, i) in projects" :key="p.title" class="card proj reveal">
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

    <section id="process" class="band">
      <div class="sec container-1200">
        <SectionHead
          num="04" label="how we'll work" title="A simple, transparent process"
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
      </div>
    </section>

    <ContactSection />
  </main>

  <footer class="footer">
    <div class="mono footer-inner">
      <span>© {{ new Date().getFullYear() }} {{ profile.name }}</span>
      <span>Built with Vue 3 · tested with Playwright</span>
    </div>
  </footer>
</template>
