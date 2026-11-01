<script setup lang="ts">
import { computed, ref } from 'vue'

const props = defineProps<{
  mx?: number
  my?: number
}>()

const hoveredTool = ref<string | null>(null)
const isPaused = ref(false)

// Gentle 3D perspective tilt reacting to mouse position
const tiltStyle = computed(() => {
  const x = (props.mx || 0) * 16
  const y = -(props.my || 0) * 12
  return {
    transform: `rotateY(${x.toFixed(1)}deg) rotateX(${y.toFixed(1)}deg)`,
  }
})

interface TechTile {
  name: string
  category: 'QA Stack' | 'AI Stack' | 'DevOps'
  bgGradient: string
  glowColor: string
  iconType: string
  desc: string
  offsetY: number
}

const techTiles: TechTile[] = [
  {
    name: 'Playwright',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #2ead33 0%, #15571b 100%)',
    glowColor: 'rgba(46, 173, 51, 0.75)',
    iconType: 'playwright',
    desc: 'High-speed E2E & Component Testing',
    offsetY: -22,
  },
  {
    name: 'TypeScript',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #3178c6 0%, #184479 100%)',
    glowColor: 'rgba(49, 120, 198, 0.75)',
    iconType: 'typescript',
    desc: 'Strict Typed Page Object Models',
    offsetY: 18,
  },
  {
    name: 'Java',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #f97316 0%, #9a3412 100%)',
    glowColor: 'rgba(249, 115, 22, 0.75)',
    iconType: 'java',
    desc: 'Enterprise Automation & Multi-Threading',
    offsetY: -35,
  },
  {
    name: 'MCPs',
    category: 'AI Stack',
    bgGradient: 'linear-gradient(145deg, #a855f7 0%, #581c87 100%)',
    glowColor: 'rgba(168, 85, 247, 0.85)',
    iconType: 'mcp',
    desc: 'Model Context Protocol Agents',
    offsetY: 10,
  },
  {
    name: 'AI Self-Healing',
    category: 'AI Stack',
    bgGradient: 'linear-gradient(145deg, #06b6d4 0%, #0e7490 100%)',
    glowColor: 'rgba(6, 182, 212, 0.8)',
    iconType: 'ai',
    desc: 'Neural DOM Self-Healing Locators',
    offsetY: -48,
  },
  {
    name: 'Jenkins',
    category: 'DevOps',
    bgGradient: 'linear-gradient(145deg, #ef4444 0%, #991b1b 100%)',
    glowColor: 'rgba(239, 68, 68, 0.75)',
    iconType: 'jenkins',
    desc: 'Declarative CI/CD Pipelines & Webhooks',
    offsetY: 26,
  },
  {
    name: 'GitHub',
    category: 'DevOps',
    bgGradient: 'linear-gradient(145deg, #27272a 0%, #09090b 100%)',
    glowColor: 'rgba(161, 161, 170, 0.7)',
    iconType: 'github',
    desc: '4x Sharded Matrix Runners',
    offsetY: -16,
  },
  {
    name: 'Selenium',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #22c55e 0%, #14532d 100%)',
    glowColor: 'rgba(34, 197, 94, 0.75)',
    iconType: 'selenium',
    desc: 'WebDriver 4 Cross-Browser Grid',
    offsetY: 22,
  },
  {
    name: 'TestNG',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #f59e0b 0%, #92400e 100%)',
    glowColor: 'rgba(245, 158, 11, 0.75)',
    iconType: 'testng',
    desc: 'Parallel Suites & DataProviders',
    offsetY: -30,
  },
  {
    name: 'Docker',
    category: 'DevOps',
    bgGradient: 'linear-gradient(145deg, #0ea5e9 0%, #0369a1 100%)',
    glowColor: 'rgba(14, 165, 233, 0.75)',
    iconType: 'docker',
    desc: 'Isolated Ephemeral Grid Runners',
    offsetY: 14,
  },
  {
    name: 'REST Assured',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #818cf8 0%, #3730a3 100%)',
    glowColor: 'rgba(129, 140, 248, 0.75)',
    iconType: 'api',
    desc: 'JSON Schema & Contract Assertions',
    offsetY: -24,
  },
  {
    name: 'Postman',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #ff6c37 0%, #9a2c06 100%)',
    glowColor: 'rgba(255, 108, 55, 0.8)',
    iconType: 'postman',
    desc: 'Automated Newman Smoke Packs',
    offsetY: 32,
  },
  {
    name: 'Claude QA',
    category: 'AI Stack',
    bgGradient: 'linear-gradient(145deg, #d97706 0%, #78350f 100%)',
    glowColor: 'rgba(217, 119, 6, 0.8)',
    iconType: 'claude',
    desc: 'LLM Log Triage & Root Cause Analysis',
    offsetY: -44,
  },
  {
    name: 'Appium',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #ec4899 0%, #9d174d 100%)',
    glowColor: 'rgba(236, 72, 153, 0.75)',
    iconType: 'appium',
    desc: 'iOS & Android Native Mobile Tests',
    offsetY: 8,
  },
]

const totalTiles = techTiles.length
// Radius of the 3D orbit cylinder (px)
const radius = 245
</script>

<template>
  <div class="tech-hand-stage" role="img" aria-label="3D hand encircled by orbiting QA and AI technology tiles">
    <!-- Studio Ambient Vignette & Velvet Drapery Background -->
    <div class="studio-backdrop" aria-hidden="true">
      <div class="velvet-folds"></div>
      <div class="studio-spotlight"></div>
      
      <!-- Typographic Headers matching reference image style -->
      <div class="studio-typography">
        <div class="typo-quote">
          <span class="quote-line-1">Tests without structure</span>
          <span class="quote-line-2">Is just <strong class="noise-highlight">NOISE.</strong></span>
        </div>
        <div class="typo-tagline">
          <span>Systems</span>
          <span>over Flakiness.</span>
        </div>
      </div>

      <!-- Bottom Studio Badge -->
      <div class="studio-bottom-badges">
        <span class="arabic-tag">هندسة الجودة والذكاء الاصطناعي</span>
        <span class="brand-pill">qa.ai/karthik.tech <span class="arrow-glyph">↗</span></span>
      </div>
    </div>

    <div class="stage-tilt" :style="tiltStyle">
      <!-- Deep 3D Ambient Space Rings -->
      <div class="orbit-glow" aria-hidden="true"></div>
      <div class="orbit-ring-guide guide-outer" aria-hidden="true"></div>
      <div class="orbit-ring-guide guide-inner" aria-hidden="true"></div>

      <!-- THE 3D SCULPTED HAND (Center Stage) -->
      <div class="hand-container" aria-hidden="true">
        <svg
          viewBox="0 0 340 500"
          class="hand-svg"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <defs>
            <!-- Realistic Skin Gradient with Studio Lighting -->
            <linearGradient id="skinMain" x1="50%" y1="0%" x2="50%" y2="100%">
              <stop offset="0%" stop-color="#FFE4D9" />
              <stop offset="25%" stop-color="#F2BAA8" />
              <stop offset="55%" stop-color="#C2849D" />
              <stop offset="85%" stop-color="#733B79" />
              <stop offset="100%" stop-color="#301147" />
            </linearGradient>

            <!-- Dual Rim Lighting (Neon Violet Left, Sky Cyan Right) -->
            <linearGradient id="rimLightGrad" x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stop-color="#C084FC" stop-opacity="0.95" />
              <stop offset="20%" stop-color="#DDD6FE" stop-opacity="0.5" />
              <stop offset="75%" stop-color="#38BDF8" stop-opacity="0.3" />
              <stop offset="100%" stop-color="#38BDF8" stop-opacity="0.95" />
            </linearGradient>

            <radialGradient id="palmShadeGrad" cx="50%" cy="50%" r="50%">
              <stop offset="0%" stop-color="#5B215E" stop-opacity="0.8" />
              <stop offset="80%" stop-color="#2D1146" stop-opacity="0.2" />
              <stop offset="100%" stop-color="#1E0A30" stop-opacity="0" />
            </radialGradient>

            <filter id="handGlow" x="-20%" y="-20%" width="140%" height="140%">
              <feGaussianBlur stdDeviation="6" result="blur" />
              <feComposite in="SourceGraphic" in2="blur" operator="over" />
            </filter>
          </defs>

          <!-- Forearm & Wrist rising into the scene -->
          <path
            d="M102 500 C96 420 106 350 118 290 C128 245 145 220 162 215 C178 220 196 245 208 290 C220 350 230 420 224 500 Z"
            fill="url(#skinMain)"
          />

          <!-- Palm Base Shadow & Concavity -->
          <ellipse cx="166" cy="270" rx="58" ry="42" fill="url(#palmShadeGrad)" />

          <!-- Thumb (gracefully curved outward to the left) -->
          <g class="finger-group thumb-group">
            <path
              d="M122 265 C102 250 72 220 70 185 C68 158 82 146 95 155 C110 166 126 210 136 245 Z"
              fill="url(#skinMain)"
            />
            <!-- Thumb Knuckle Shading & Crease -->
            <path d="M85 195 Q98 190 112 205" stroke="rgba(255,255,255,0.22)" stroke-width="2" stroke-linecap="round" fill="none" />
            <!-- Thumb fingernail highlight -->
            <ellipse cx="82" cy="160" rx="7.5" ry="11" transform="rotate(-18 82 160)" fill="#FFF5F2" opacity="0.7" />
          </g>

          <!-- Index Finger (reaching tall & curved) -->
          <g class="finger-group index-group">
            <path
              d="M136 220 C132 165 125 110 132 55 C135 38 150 36 156 52 C164 105 165 165 163 220 Z"
              fill="url(#skinMain)"
            />
            <!-- Joint crease lines -->
            <path d="M135 150 Q146 148 158 152" stroke="rgba(255,255,255,0.22)" stroke-width="1.8" stroke-linecap="round" fill="none" />
            <path d="M136 95 Q145 93 154 97" stroke="rgba(255,255,255,0.22)" stroke-width="1.8" stroke-linecap="round" fill="none" />
            <!-- Fingernail reflection -->
            <ellipse cx="144" cy="50" rx="6" ry="10" fill="#FFF5F2" opacity="0.8" />
          </g>

          <!-- Middle Finger (Tallest center finger) -->
          <g class="finger-group middle-group">
            <path
              d="M161 215 C164 150 166 85 173 24 C175 8 192 9 194 26 C198 85 196 150 189 215 Z"
              fill="url(#skinMain)"
            />
            <!-- Joint crease lines -->
            <path d="M166 140 Q178 138 191 142" stroke="rgba(255,255,255,0.22)" stroke-width="1.8" stroke-linecap="round" fill="none" />
            <path d="M168 80 Q179 78 190 82" stroke="rgba(255,255,255,0.22)" stroke-width="1.8" stroke-linecap="round" fill="none" />
            <!-- Fingernail reflection -->
            <ellipse cx="183" cy="22" rx="6.5" ry="11" fill="#FFF5F2" opacity="0.85" />
          </g>

          <!-- Ring Finger -->
          <g class="finger-group ring-group">
            <path
              d="M187 220 C194 160 199 105 208 50 C210 35 225 38 227 54 C226 105 217 160 208 225 Z"
              fill="url(#skinMain)"
            />
            <!-- Joint crease lines -->
            <path d="M196 150 Q207 148 219 153" stroke="rgba(255,255,255,0.22)" stroke-width="1.8" stroke-linecap="round" fill="none" />
            <path d="M201 95 Q211 93 221 97" stroke="rgba(255,255,255,0.22)" stroke-width="1.8" stroke-linecap="round" fill="none" />
            <!-- Fingernail reflection -->
            <ellipse cx="217" cy="48" rx="6" ry="10" fill="#FFF5F2" opacity="0.8" />
          </g>

          <!-- Pinky Finger -->
          <g class="finger-group pinky-group">
            <path
              d="M206 240 C218 190 229 140 239 90 C241 76 254 79 255 93 C254 140 238 190 223 250 Z"
              fill="url(#skinMain)"
            />
            <!-- Fingernail reflection -->
            <ellipse cx="247" cy="88" rx="5.5" ry="9" fill="#FFF5F2" opacity="0.75" />
          </g>

          <!-- Palm Highlight Creases -->
          <path
            d="M116 250 Q160 235 208 248"
            stroke="rgba(255, 255, 255, 0.28)"
            stroke-width="2.5"
            stroke-linecap="round"
          />
          <path
            d="M132 278 Q166 268 198 285"
            stroke="rgba(255, 255, 255, 0.2)"
            stroke-width="2"
            stroke-linecap="round"
          />

          <!-- Glowing Ambient Rim Light on Silhouettes -->
          <path
            d="M70 185 C68 158 82 146 95 155 C110 166 126 210 132 55 C135 38 150 36 156 52 C164 105 166 85 173 24 C175 8 192 9 194 26 C198 85 208 50 C210 35 225 38 227 54 C239 90 C241 76 254 79 255 93"
            stroke="url(#rimLightGrad)"
            stroke-width="3.5"
            fill="none"
            opacity="0.9"
            filter="url(#handGlow)"
          />
        </svg>

        <!-- Floating Energy Core hovered in palm -->
        <div class="palm-core" aria-hidden="true">
          <div class="core-flare"></div>
        </div>
      </div>

      <!-- 3D ORBITING RING OF SQUIRCLES (CYLINDER) -->
      <div
        class="orbit-carousel"
        :class="{ paused: isPaused }"
        aria-hidden="true"
      >
        <div
          v-for="(tile, i) in techTiles"
          :key="tile.name"
          class="tile-slot"
          :style="{
            transform: `rotateY(${(360 / totalTiles) * i}deg) translateZ(${radius}px) translateY(${tile.offsetY}px) rotateY(${-(360 / totalTiles) * i}deg)`
          }"
          @mouseenter="hoveredTool = tile.name; isPaused = true"
          @mouseleave="hoveredTool = null; isPaused = false"
        >
          <!-- 3D Chunky Squircle Tile with Beveled Extrusion -->
          <div
            class="app-squircle"
            :style="{
              background: tile.bgGradient,
              '--tile-glow': tile.glowColor,
            }"
          >
            <!-- 3D Beveled Side Wall (Extrusion illusion) -->
            <div class="squircle-bevel"></div>

            <!-- Glossy Glass Reflection Top Half -->
            <div class="squircle-gloss"></div>

            <!-- Crisp Brand / Tech Vector Icon -->
            <div class="tile-icon-wrap">
              <!-- PLAYWRIGHT -->
              <svg v-if="tile.iconType === 'playwright'" viewBox="0 0 40 40" width="32" height="32">
                <path d="M12 28 C9 24 9 16 14 12 C19 8 26 10 28 14 C30 18 29 25 24 28 Z" fill="#FF6B6B" />
                <path d="M22 30 C19 28 17 21 21 16 C25 12 31 13 33 17 C35 21 34 27 29 30 Z" fill="#2EAD33" />
                <circle cx="16" cy="18" r="2.5" fill="#FFF" />
                <circle cx="27" cy="20" r="2.5" fill="#FFF" />
              </svg>

              <!-- TYPESCRIPT -->
              <svg v-else-if="tile.iconType === 'typescript'" viewBox="0 0 40 40" width="32" height="32">
                <text x="20" y="27" font-family="'JetBrains Mono', system-ui, sans-serif" font-size="20" font-weight="900" fill="#FFF" text-anchor="middle" letter-spacing="-1">TS</text>
              </svg>

              <!-- JAVA -->
              <svg v-else-if="tile.iconType === 'java'" viewBox="0 0 40 40" width="32" height="32">
                <!-- Coffee cup & stylized steam plume -->
                <path d="M11 21 C11 28 15 32 22 32 C28 32 31 28 31 21 Z" fill="#FFF" />
                <path d="M29 23 C33 23 35 24 35 26 C35 28 33 29 29 29" stroke="#FFF" stroke-width="2.5" stroke-linecap="round" fill="none" />
                <path d="M16 16 Q19 13 17 9" stroke="#FFF" stroke-width="2.2" stroke-linecap="round" fill="none" />
                <path d="M22 16 Q25 13 23 9" stroke="#FFF" stroke-width="2.2" stroke-linecap="round" fill="none" />
                <path d="M8 34 H34" stroke="#FFF" stroke-width="2" stroke-linecap="round" />
              </svg>

              <!-- SELENIUM -->
              <svg v-else-if="tile.iconType === 'selenium'" viewBox="0 0 40 40" width="32" height="32">
                <text x="20" y="27" font-family="'JetBrains Mono', system-ui, sans-serif" font-size="20" font-weight="900" fill="#FFF" text-anchor="middle" letter-spacing="-0.5">Se</text>
              </svg>

              <!-- TESTNG -->
              <svg v-else-if="tile.iconType === 'testng'" viewBox="0 0 40 40" width="32" height="32">
                <text x="20" y="27" font-family="'JetBrains Mono', system-ui, sans-serif" font-size="18" font-weight="900" fill="#FFF" text-anchor="middle">TG</text>
              </svg>

              <!-- MCPS (Model Context Protocol) -->
              <svg v-else-if="tile.iconType === 'mcp'" viewBox="0 0 40 40" width="32" height="32">
                <circle cx="12" cy="13" r="3.5" fill="#FFF" />
                <circle cx="28" cy="13" r="3.5" fill="#FFF" />
                <circle cx="20" cy="28" r="4.2" fill="#FFF" />
                <line x1="12" y1="13" x2="20" y2="28" stroke="#FFF" stroke-width="2.5" />
                <line x1="28" y1="13" x2="20" y2="28" stroke="#FFF" stroke-width="2.5" />
                <line x1="12" y1="13" x2="28" y2="13" stroke="#FFF" stroke-width="2" stroke-dasharray="2 2" />
              </svg>

              <!-- AI SELF-HEALING -->
              <svg v-else-if="tile.iconType === 'ai'" viewBox="0 0 40 40" width="32" height="32">
                <!-- 4-point sparkle star with orbiting nodes -->
                <path d="M20 6 L23.5 16.5 L34 20 L23.5 23.5 L20 34 L16.5 23.5 L6 20 L16.5 16.5 Z" fill="#FFF" />
                <circle cx="30" cy="10" r="2.5" fill="#FFF" />
                <circle cx="10" cy="30" r="2" fill="#FFF" />
              </svg>

              <!-- JENKINS -->
              <svg v-else-if="tile.iconType === 'jenkins'" viewBox="0 0 40 40" width="32" height="32">
                <circle cx="20" cy="18" r="10" fill="#FFE2D1" />
                <path d="M12 12 Q20 8 28 12 L27 8 Q20 5 13 8 Z" fill="#222" />
                <circle cx="17" cy="17" r="1.5" fill="#222" />
                <circle cx="23" cy="17" r="1.5" fill="#222" />
                <path d="M18 21 Q20 23 22 21" stroke="#222" stroke-width="1.5" fill="none" />
                <polygon points="16 28 24 28 20 25" fill="#D33833" />
              </svg>

              <!-- GITHUB -->
              <svg v-else-if="tile.iconType === 'github'" viewBox="0 0 40 40" width="32" height="32">
                <path fill="#FFF" fill-rule="evenodd" d="M20 7 C12.8 7 7 12.8 7 20 C7 25.7 10.7 30.6 15.9 32.3 C16.5 32.4 16.8 32 16.8 31.7 C16.8 31.4 16.8 30.4 16.8 29.2 C13.2 30 12.4 27.5 12.4 27.5 C11.9 26 11 25.6 11 25.6 C9.8 24.8 11.1 24.8 11.1 24.8 C12.4 24.9 13.1 26.2 13.1 26.2 C14.3 28.3 16.3 27.6 17 27.3 C17.1 26.4 17.5 25.8 17.9 25.4 C15 25.1 12 24 12 18.9 C12 17.5 12.5 16.3 13.3 15.3 C13.2 15 12.7 13.6 13.4 11.8 C13.4 11.8 14.5 11.5 17 13.1 C18 12.8 19.1 12.7 20.1 12.7 C21.1 12.7 22.2 12.8 23.2 13.1 C25.7 11.5 26.8 11.8 26.8 11.8 C27.5 13.6 27 15 26.9 15.3 C27.7 16.3 28.2 17.5 28.2 18.9 C28.2 24 25.2 25.1 22.3 25.4 C22.8 25.8 23.2 26.6 23.2 27.9 C23.2 29.6 23.2 31.1 23.2 31.5 C23.2 31.9 23.5 32.4 24.1 32.3 C29.3 30.6 33 25.7 33 20 C33 12.8 27.2 7 20 7 Z" />
              </svg>

              <!-- DOCKER -->
              <svg v-else-if="tile.iconType === 'docker'" viewBox="0 0 40 40" width="32" height="32">
                <path d="M9 24 C9 23 11 21 17 21 C19 18 24 18 26 22 C31 22 34 25 34 27 C34 30 29 32 22 32 C13 32 9 29 9 24 Z" fill="#FFF" />
                <rect x="14" y="16" width="3" height="3" rx="0.5" fill="#FFF" />
                <rect x="18" y="16" width="3" height="3" rx="0.5" fill="#FFF" />
                <rect x="22" y="16" width="3" height="3" rx="0.5" fill="#FFF" />
                <rect x="18" y="12" width="3" height="3" rx="0.5" fill="#FFF" />
                <circle cx="30" cy="24" r="1" fill="#0ea5e9" />
              </svg>

              <!-- REST ASSURED (API) -->
              <svg v-else-if="tile.iconType === 'api'" viewBox="0 0 40 40" width="32" height="32">
                <path d="M21 8 L12 22 L19 22 L17 32 L28 18 L21 18 Z" fill="#FFF" />
              </svg>

              <!-- POSTMAN -->
              <svg v-else-if="tile.iconType === 'postman'" viewBox="0 0 40 40" width="32" height="32">
                <circle cx="20" cy="20" r="10" fill="#FFF" />
                <path d="M15 20 L23 15 L21 25 Z" fill="#FF6C37" />
              </svg>

              <!-- CLAUDE QA -->
              <svg v-else-if="tile.iconType === 'claude'" viewBox="0 0 40 40" width="32" height="32">
                <!-- 8-ray generative starburst -->
                <path d="M20 9 L22 17 L30 15 L24 21 L30 27 L22 25 L20 33 L18 25 L10 27 L16 21 L10 15 L18 17 Z" fill="#FFF" />
              </svg>

              <!-- APPIUM -->
              <svg v-else-if="tile.iconType === 'appium'" viewBox="0 0 40 40" width="32" height="32">
                <rect x="13" y="9" width="14" height="22" rx="3" fill="#FFF" />
                <rect x="15" y="12" width="10" height="14" rx="1" fill="#ec4899" />
                <circle cx="20" cy="28.5" r="1" fill="#ec4899" />
              </svg>
            </div>
          </div>
        </div>
      </div>

      <!-- INTERACTIVE FLOATING TOOLTIP CALLOUT -->
      <Transition name="fade">
        <div v-if="hoveredTool" class="tool-callout mono">
          <span class="callout-sparkle">✦</span>
          <span class="callout-name">{{ hoveredTool }}</span>
          <span class="callout-cat">{{ techTiles.find(t => t.name === hoveredTool)?.category }}</span>
          <span class="callout-desc">{{ techTiles.find(t => t.name === hoveredTool)?.desc }}</span>
        </div>
      </Transition>
    </div>
  </div>
</template>

<style scoped>
.tech-hand-stage {
  position: relative;
  width: 100%;
  max-width: 580px;
  height: 520px;
  perspective: 1200px;
  display: flex;
  align-items: center;
  justify-content: center;
  user-select: none;
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 30px 80px rgba(0, 0, 0, 0.7), 0 0 50px rgba(109, 40, 217, 0.35);
  border: 1px solid rgba(167, 139, 250, 0.25);
  background: #120724;
}

/* Studio Backdrop mimicking the deep purple curtain & typography in reference */
.studio-backdrop {
  position: absolute;
  inset: 0;
  pointer-events: none;
  z-index: 0;
  overflow: hidden;
}

/* Vertical velvet drapery texture */
.velvet-folds {
  position: absolute;
  inset: 0;
  background: repeating-linear-gradient(
    90deg,
    rgba(21, 8, 38, 0.95) 0px,
    rgba(38, 14, 66, 0.92) 28px,
    rgba(54, 18, 92, 0.88) 56px,
    rgba(38, 14, 66, 0.92) 84px,
    rgba(21, 8, 38, 0.95) 112px
  );
  opacity: 0.85;
}

/* Atmospheric spotlight behind the hand */
.studio-spotlight {
  position: absolute;
  top: 15%;
  left: 50%;
  width: 360px;
  height: 360px;
  margin-left: -180px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(147, 51, 234, 0.45) 0%, rgba(91, 33, 182, 0.25) 45%, transparent 75%);
  filter: blur(40px);
}

/* Studio Typography matching the reference image layout */
.studio-typography {
  position: absolute;
  top: 24px;
  left: 28px;
  right: 28px;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  z-index: 1;
}

.typo-quote {
  display: flex;
  flex-direction: column;
  line-height: 1.25;
}

.quote-line-1 {
  font-size: 13px;
  font-weight: 500;
  color: #c4b5fd;
  letter-spacing: -0.01em;
}

.quote-line-2 {
  font-size: 15px;
  font-weight: 700;
  color: #ffffff;
  letter-spacing: -0.02em;
}

.noise-highlight {
  color: #a855f7;
  font-weight: 900;
  letter-spacing: 0.05em;
  text-shadow: 0 0 12px rgba(168, 85, 247, 0.7);
}

.typo-tagline {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  font-size: 11px;
  font-weight: 600;
  color: #a78bfa;
  letter-spacing: 0.02em;
  opacity: 0.85;
  line-height: 1.3;
}

.studio-bottom-badges {
  position: absolute;
  bottom: 16px;
  left: 24px;
  right: 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 1;
}

.arabic-tag {
  font-size: 12px;
  font-weight: 600;
  color: rgba(216, 180, 254, 0.8);
  font-family: system-ui, sans-serif;
  letter-spacing: 0.03em;
}

.brand-pill {
  font-size: 10px;
  font-family: 'JetBrains Mono', monospace;
  font-weight: 600;
  color: #e9d5ff;
  background: rgba(88, 28, 135, 0.5);
  border: 1px solid rgba(168, 85, 247, 0.4);
  padding: 3px 10px;
  border-radius: 999px;
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.arrow-glyph {
  color: #38bdf8;
  font-size: 11px;
}

/* 3D Tilt Stage */
.stage-tilt {
  position: relative;
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  transition: transform 0.2s cubic-bezier(0.16, 1, 0.3, 1);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2;
}

/* Ambient Back Glow & Guides */
.orbit-glow {
  position: absolute;
  width: 340px;
  height: 340px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(168, 85, 247, 0.35) 0%, rgba(56, 189, 248, 0.15) 50%, transparent 75%);
  filter: blur(50px);
  pointer-events: none;
  transform: translateZ(-60px);
}

.orbit-ring-guide {
  position: absolute;
  border-radius: 50%;
  pointer-events: none;
}

.guide-outer {
  width: 480px;
  height: 220px;
  border: 1px dashed rgba(167, 139, 250, 0.25);
  transform: rotateX(72deg) translateZ(-15px);
}

.guide-inner {
  width: 500px;
  height: 240px;
  border: 1px solid rgba(56, 189, 248, 0.18);
  transform: rotateX(72deg) translateZ(15px);
}

/* 3D Sculpted Hand Container */
.hand-container {
  position: absolute;
  bottom: 0px;
  width: 310px;
  height: 450px;
  display: flex;
  align-items: center;
  justify-content: center;
  transform-style: preserve-3d;
  transform: translateZ(10px);
  pointer-events: none;
  animation: hand-sway 7s ease-in-out infinite alternate;
}

@keyframes hand-sway {
  0% { transform: translateZ(10px) translateY(0) rotate(-0.8deg); }
  100% { transform: translateZ(10px) translateY(-12px) rotate(1deg); }
}

.hand-svg {
  width: 100%;
  height: 100%;
  filter: drop-shadow(0 25px 45px rgba(0, 0, 0, 0.85)) drop-shadow(0 0 35px rgba(126, 34, 206, 0.5));
}

.palm-core {
  position: absolute;
  top: 185px;
  left: 50%;
  width: 40px;
  height: 40px;
  margin-left: -20px;
  border-radius: 50%;
  background: radial-gradient(circle, #ffffff 0%, #38bdf8 40%, rgba(168, 85, 247, 0.8) 75%, transparent 100%);
  box-shadow: 0 0 25px 8px #38bdf8, 0 0 50px 14px rgba(168, 85, 247, 0.7);
  animation: core-pulse 2.4s infinite ease-in-out;
  transform: translateZ(35px);
}

.core-flare {
  position: absolute;
  inset: -6px;
  border-radius: 50%;
  border: 1.5px solid rgba(255, 255, 255, 0.8);
  animation: core-spin 6s linear infinite;
}

@keyframes core-pulse {
  0%, 100% { transform: translateZ(35px) scale(0.9); opacity: 0.85; }
  50% { transform: translateZ(35px) scale(1.18); opacity: 1; }
}

@keyframes core-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* 3D Orbiting Ring Carousel */
.orbit-carousel {
  position: absolute;
  width: 0;
  height: 0;
  transform-style: preserve-3d;
  animation: orbit-cyl 30s linear infinite;
}

.orbit-carousel.paused {
  animation-play-state: paused;
}

@keyframes orbit-cyl {
  from {
    transform: rotateX(14deg) rotateY(0deg);
  }
  to {
    transform: rotateX(14deg) rotateY(360deg);
  }
}

.tile-slot {
  position: absolute;
  top: -32px;
  left: -32px;
  width: 64px;
  height: 64px;
  transform-style: preserve-3d;
}

/* 3D Squircle App Tile (Exact Apple iOS/macOS 3D App Icon style from reference) */
.app-squircle {
  position: relative;
  width: 62px;
  height: 62px;
  border-radius: 19px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: transform 0.28s cubic-bezier(0.16, 1, 0.3, 1), filter 0.28s ease, box-shadow 0.28s ease;
  transform-style: preserve-3d;
  border: 1px solid rgba(255, 255, 255, 0.35);
  box-shadow:
    0 2px 0 rgba(255, 255, 255, 0.5) inset,
    0 -3px 0 rgba(0, 0, 0, 0.35) inset,
    0 6px 14px rgba(0, 0, 0, 0.6),
    0 16px 30px -4px var(--tile-glow);
}

/* 3D Extruded Bevel behind the front tile */
.squircle-bevel {
  position: absolute;
  inset: -1px;
  border-radius: 20px;
  background: inherit;
  filter: brightness(0.65) saturate(1.3);
  transform: translateZ(-9px);
  pointer-events: none;
  box-shadow: 0 0 12px rgba(0, 0, 0, 0.8);
}

.tile-slot:hover .app-squircle {
  transform: scale(1.25) translateZ(40px);
  filter: brightness(1.22);
  border-color: rgba(255, 255, 255, 0.95);
  box-shadow:
    0 2px 0 #fff inset,
    0 -3px 0 rgba(0, 0, 0, 0.4) inset,
    0 12px 28px rgba(0, 0, 0, 0.8),
    0 22px 42px 2px var(--tile-glow);
}

/* Glossy glass reflection curve across top half */
.squircle-gloss {
  position: absolute;
  top: 1px;
  left: 2px;
  right: 2px;
  height: 48%;
  background: linear-gradient(
    180deg,
    rgba(255, 255, 255, 0.65) 0%,
    rgba(255, 255, 255, 0.2) 65%,
    rgba(255, 255, 255, 0) 100%
  );
  border-radius: 18px 18px 30% 30% / 18px 18px 15% 15%;
  pointer-events: none;
  z-index: 3;
}

.tile-icon-wrap {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  justify-content: center;
  filter: drop-shadow(0 2px 5px rgba(0, 0, 0, 0.55));
}

/* Floating interactive Tooltip */
.tool-callout {
  position: absolute;
  bottom: 22px;
  left: 50%;
  transform: translateX(-50%) translateZ(70px);
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 18px;
  border-radius: 999px;
  background: rgba(18, 7, 36, 0.95);
  border: 1px solid rgba(192, 132, 252, 0.6);
  box-shadow: 0 12px 35px rgba(0, 0, 0, 0.85), 0 0 25px rgba(147, 51, 234, 0.6);
  backdrop-filter: blur(14px);
  z-index: 10;
  white-space: nowrap;
}

.callout-sparkle {
  color: #38bdf8;
  font-size: 13px;
}

.callout-name {
  color: #fff;
  font-size: 13px;
  font-weight: 700;
}

.callout-cat {
  font-size: 10px;
  padding: 2px 7px;
  border-radius: 4px;
  background: rgba(56, 189, 248, 0.18);
  color: #38bdf8;
  border: 1px solid rgba(56, 189, 248, 0.35);
  font-weight: 600;
}

.callout-desc {
  font-size: 11px;
  color: #c4b5fd;
  opacity: 0.9;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateX(-50%) translateY(10px) translateZ(70px);
}

@media (max-width: 600px) {
  .tech-hand-stage {
    height: 420px;
    transform: scale(0.85);
  }
  .callout-desc {
    display: none;
  }
}
</style>
