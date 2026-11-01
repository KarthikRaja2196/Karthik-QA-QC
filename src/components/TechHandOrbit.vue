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
  const x = (props.mx || 0) * 14
  const y = -(props.my || 0) * 10
  return {
    transform: `rotateY(${x.toFixed(1)}deg) rotateX(${y.toFixed(1)}deg)`,
  }
})

interface TechTile {
  name: string
  category: 'QA Stack' | 'AI Stack' | 'DevOps'
  bgGradient: string
  glowColor: string
  iconSrc: string
  desc: string
  offsetY: number
}

const techTiles: TechTile[] = [
  {
    name: 'Playwright',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #1E293B 0%, #0F172A 100%)',
    glowColor: 'rgba(46, 173, 51, 0.85)',
    iconSrc: '/icons/playwright.svg',
    desc: 'High-speed E2E & Component Testing',
    offsetY: -24,
  },
  {
    name: 'TypeScript',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #3178C6 0%, #1A5494 100%)',
    glowColor: 'rgba(49, 120, 198, 0.85)',
    iconSrc: '/icons/typescript.svg',
    desc: 'Strict Typed Page Object Models',
    offsetY: 20,
  },
  {
    name: 'Java',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #FFF5ED 0%, #F5DEC9 100%)',
    glowColor: 'rgba(234, 45, 46, 0.8)',
    iconSrc: '/icons/java.svg',
    desc: 'Enterprise Automation & Multi-Threading',
    offsetY: -36,
  },
  {
    name: 'Selenium',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #1F2937 0%, #111827 100%)',
    glowColor: 'rgba(67, 176, 42, 0.85)',
    iconSrc: '/icons/selenium.svg',
    desc: 'WebDriver 4 Cross-Browser Grid',
    offsetY: 24,
  },
  {
    name: 'Jenkins',
    category: 'DevOps',
    bgGradient: 'linear-gradient(145deg, #FFFFFF 0%, #ECE9F2 100%)',
    glowColor: 'rgba(211, 56, 51, 0.85)',
    iconSrc: '/icons/jenkins.svg',
    desc: 'Declarative CI/CD Pipelines & Webhooks',
    offsetY: -28,
  },
  {
    name: 'Docker',
    category: 'DevOps',
    bgGradient: 'linear-gradient(145deg, #2496ED 0%, #1063A5 100%)',
    glowColor: 'rgba(36, 150, 237, 0.85)',
    iconSrc: '/icons/docker.svg',
    desc: 'Isolated Ephemeral Grid Runners',
    offsetY: 16,
  },
  {
    name: 'Postman',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #FF6C37 0%, #B83B09 100%)',
    glowColor: 'rgba(255, 108, 55, 0.85)',
    iconSrc: '/icons/postman.svg',
    desc: 'Automated Newman Smoke Packs',
    offsetY: 34,
  },
  {
    name: 'GitHub',
    category: 'DevOps',
    bgGradient: 'linear-gradient(145deg, #24292E 0%, #0D1117 100%)',
    glowColor: 'rgba(192, 132, 252, 0.75)',
    iconSrc: '/icons/github.svg',
    desc: '4x Sharded Matrix Runners',
    offsetY: -16,
  },
  {
    name: 'TestNG',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #E55322 0%, #8E2300 100%)',
    glowColor: 'rgba(229, 83, 34, 0.85)',
    iconSrc: '/icons/testng.svg',
    desc: 'Parallel Suites & DataProviders',
    offsetY: -32,
  },
  {
    name: 'MCPs',
    category: 'AI Stack',
    bgGradient: 'linear-gradient(145deg, #8B5CF6 0%, #52199C 100%)',
    glowColor: 'rgba(139, 92, 246, 0.9)',
    iconSrc: '/icons/mcp.svg',
    desc: 'Model Context Protocol Agents',
    offsetY: 10,
  },
  {
    name: 'AI Self-Healing',
    category: 'AI Stack',
    bgGradient: 'linear-gradient(145deg, #0F172A 0%, #1E1B4B 100%)',
    glowColor: 'rgba(56, 189, 248, 0.85)',
    iconSrc: '/icons/ai-healing.svg',
    desc: 'Neural DOM Self-Healing Locators',
    offsetY: -48,
  },
  {
    name: 'REST Assured',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #4F46E5 0%, #2A247A 100%)',
    glowColor: 'rgba(79, 70, 229, 0.85)',
    iconSrc: '/icons/rest-assured.svg',
    desc: 'JSON Schema & Contract Assertions',
    offsetY: -22,
  },
  {
    name: 'Python',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #1E293B 0%, #0F172A 100%)',
    glowColor: 'rgba(245, 158, 11, 0.8)',
    iconSrc: '/icons/python.svg',
    desc: 'PyTest Automation & Data Pipelines',
    offsetY: 26,
  },
  {
    name: 'Appium',
    category: 'QA Stack',
    bgGradient: 'linear-gradient(145deg, #662D91 0%, #3B0E5E 100%)',
    glowColor: 'rgba(236, 72, 153, 0.8)',
    iconSrc: '/icons/appium.svg',
    desc: 'iOS & Android Native Mobile Tests',
    offsetY: 6,
  },
]

const totalTiles = techTiles.length
// Radius of the 3D orbit cylinder (px)
const radius = 255
</script>

<template>
  <div class="tech-hand-stage" role="img" aria-label="Photorealistic 3D hand encircled by orbiting official QA and AI technology tiles">
    <!-- Studio Ambient Vignette & Velvet Drapery Background -->
    <div class="studio-backdrop" aria-hidden="true">
      <div class="velvet-folds"></div>
      <div class="studio-spotlight"></div>
      
      <!-- Studio Typography matching reference poster layout -->
      <div class="studio-typography">
        <div class="typo-quote">
          <span class="quote-line-1">Tests without structure</span>
          <span class="quote-line-2">Is just <strong class="noise-highlight">NOISE.</strong></span>
        </div>
        <div class="typo-tagline">
          <span>Systems over Services.</span>
          <span class="tagline-sub">AI-Augmented QA</span>
        </div>
      </div>

      <!-- Bottom Studio Badge (Clean English Tech Labels - Zero Arabic) -->
      <div class="studio-bottom-badges">
        <span class="tech-tag mono">// AUTOMATION ARCHITECTURE & AI</span>
        <span class="brand-pill mono">qa.ai/karthik.tech <span class="arrow-glyph">↗</span></span>
      </div>
    </div>

    <!-- 3D Perspective Stage -->
    <div class="stage-tilt" :style="tiltStyle">
      <!-- Deep 3D Ambient Space Rings -->
      <div class="orbit-glow" aria-hidden="true"></div>
      <div class="orbit-ring-guide guide-outer" aria-hidden="true"></div>
      <div class="orbit-ring-guide guide-inner" aria-hidden="true"></div>

      <!-- PHOTOREALISTIC 3D SCULPTED HAND (Center of 3D Scene) -->
      <div class="hand-3d-anchor" aria-hidden="true">
        <picture class="hand-picture">
          <source srcset="/images/hand-3d.webp" type="image/webp" />
          <img
            src="/images/hand-3d.png"
            alt="3D Hand reaching upward"
            class="hand-render-img"
            loading="eager"
            decoding="async"
          />
        </picture>

        <!-- Dynamic Ambient Violet Rim Light Overlays -->
        <div class="hand-rim-glow" aria-hidden="true"></div>

        <!-- "Ideas ignite" AI Energy Spark at Fingertip (from Reference 2) -->
        <div class="fingertip-spark" aria-hidden="true">
          <div class="spark-core"></div>
          <div class="spark-ring ring-1"></div>
          <div class="spark-ring ring-2"></div>
        </div>
      </div>

      <!-- 3D ORBITING RING OF SQUIRCLES (CYLINDER ENCIRCLING THE HAND) -->
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
          <!-- 3D Chunky Squircle Tile with Beveled Extrusion & Specular Gloss -->
          <div
            class="app-squircle"
            :style="{
              background: tile.bgGradient,
              '--tile-glow': tile.glowColor,
            }"
          >
            <!-- 3D Beveled Side Wall (Extrusion depth) -->
            <div class="squircle-bevel"></div>

            <!-- Glossy Glass Reflection Top Half -->
            <div class="squircle-gloss"></div>

            <!-- OFFICIAL VECTOR LOGO (Bold, High Contrast & Highly Visible) -->
            <div class="tile-icon-wrap">
              <img
                :src="tile.iconSrc"
                :alt="tile.name"
                class="official-logo-img"
                loading="eager"
                decoding="async"
              />
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
  max-width: 600px;
  height: 550px;
  perspective: 1200px;
  display: flex;
  align-items: center;
  justify-content: center;
  user-select: none;
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 30px 80px rgba(0, 0, 0, 0.75), 0 0 50px rgba(109, 40, 217, 0.35);
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
  width: 400px;
  height: 400px;
  margin-left: -200px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(147, 51, 234, 0.45) 0%, rgba(91, 33, 182, 0.25) 45%, transparent 75%);
  filter: blur(45px);
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
  text-shadow: 0 0 14px rgba(168, 85, 247, 0.8);
}

.typo-tagline {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  font-size: 12px;
  font-weight: 600;
  color: #a78bfa;
  letter-spacing: 0.02em;
  line-height: 1.3;
}

.tagline-sub {
  font-size: 10px;
  color: #38bdf8;
  font-family: 'JetBrains Mono', monospace;
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

.tech-tag {
  font-size: 11px;
  font-weight: 600;
  color: rgba(216, 180, 254, 0.85);
  letter-spacing: 0.03em;
}

.brand-pill {
  font-size: 10px;
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
  width: 380px;
  height: 380px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(168, 85, 247, 0.35) 0%, rgba(56, 189, 248, 0.15) 50%, transparent 75%);
  filter: blur(55px);
  pointer-events: none;
  transform: translateZ(-60px);
}

.orbit-ring-guide {
  position: absolute;
  border-radius: 50%;
  pointer-events: none;
}

.guide-outer {
  width: 520px;
  height: 240px;
  border: 1px dashed rgba(167, 139, 250, 0.25);
  transform: rotateX(72deg) translateZ(-15px);
}

.guide-inner {
  width: 540px;
  height: 260px;
  border: 1px solid rgba(56, 189, 248, 0.18);
  transform: rotateX(72deg) translateZ(15px);
}

/* PHOTOREALISTIC 3D HAND ANCHOR */
.hand-3d-anchor {
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%) translateZ(0px);
  width: 260px;
  height: 470px;
  display: flex;
  align-items: flex-end;
  justify-content: center;
  pointer-events: none;
  animation: hand-sway 7s ease-in-out infinite alternate;
}

@keyframes hand-sway {
  0% { transform: translateX(-50%) translateZ(0px) translateY(0) rotate(-0.5deg); }
  100% { transform: translateX(-50%) translateZ(0px) translateY(-10px) rotate(0.8deg); }
}

.hand-picture {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: flex-end;
  justify-content: center;
}

.hand-render-img {
  width: 100%;
  height: auto;
  max-height: 470px;
  object-fit: contain;
  filter: drop-shadow(0 20px 45px rgba(0, 0, 0, 0.9)) drop-shadow(0 0 25px rgba(147, 51, 234, 0.45));
}

.hand-rim-glow {
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: radial-gradient(circle at 50% 30%, rgba(168, 85, 247, 0.25) 0%, transparent 60%);
  mix-blend-mode: screen;
}

/* Fingertip "Ideas ignite" Energy Spark (Ref 2 Inspiration) */
.fingertip-spark {
  position: absolute;
  top: 15px;
  left: 50%;
  transform: translateX(-50%);
  width: 24px;
  height: 24px;
  pointer-events: none;
}

.spark-core {
  position: absolute;
  inset: 6px;
  border-radius: 50%;
  background: #ffffff;
  box-shadow: 0 0 18px 4px #a855f7, 0 0 35px 8px #38bdf8;
  animation: spark-pulse 1.8s infinite ease-in-out;
}

.spark-ring {
  position: absolute;
  inset: 0;
  border-radius: 50%;
  border: 1px solid rgba(168, 85, 247, 0.7);
  animation: spark-ripple 2.4s infinite ease-out;
}

.ring-2 {
  animation-delay: 1.2s;
  border-color: rgba(56, 189, 248, 0.6);
}

@keyframes spark-pulse {
  0%, 100% { transform: scale(0.85); opacity: 0.9; }
  50% { transform: scale(1.3); opacity: 1; }
}

@keyframes spark-ripple {
  0% { transform: scale(0.5); opacity: 1; }
  100% { transform: scale(2.6); opacity: 0; }
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
  top: -36px;
  left: -36px;
  width: 72px;
  height: 72px;
  transform-style: preserve-3d;
}

/* 3D Squircle App Tile (Large, Chunky, High-Visibility) */
.app-squircle {
  position: relative;
  width: 72px;
  height: 72px;
  border-radius: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: transform 0.28s cubic-bezier(0.16, 1, 0.3, 1), filter 0.28s ease, box-shadow 0.28s ease;
  transform-style: preserve-3d;
  border: 1.5px solid rgba(255, 255, 255, 0.4);
  box-shadow:
    0 2px 0 rgba(255, 255, 255, 0.6) inset,
    0 -3px 0 rgba(0, 0, 0, 0.4) inset,
    0 8px 18px rgba(0, 0, 0, 0.65),
    0 18px 36px -4px var(--tile-glow);
}

/* 3D Extruded Bevel behind the front tile */
.squircle-bevel {
  position: absolute;
  inset: -1px;
  border-radius: 23px;
  background: inherit;
  filter: brightness(0.65) saturate(1.3);
  transform: translateZ(-10px);
  pointer-events: none;
  box-shadow: 0 0 14px rgba(0, 0, 0, 0.8);
}

.tile-slot:hover .app-squircle {
  transform: scale(1.28) translateZ(45px);
  filter: brightness(1.25);
  border-color: rgba(255, 255, 255, 0.95);
  box-shadow:
    0 2px 0 #fff inset,
    0 -3px 0 rgba(0, 0, 0, 0.4) inset,
    0 14px 32px rgba(0, 0, 0, 0.85),
    0 24px 48px 2px var(--tile-glow);
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
    rgba(255, 255, 255, 0.5) 0%,
    rgba(255, 255, 255, 0.15) 65%,
    rgba(255, 255, 255, 0) 100%
  );
  border-radius: 21px 21px 30% 30% / 21px 21px 15% 15%;
  pointer-events: none;
  z-index: 3;
}

.tile-icon-wrap {
  position: relative;
  z-index: 2;
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.official-logo-img {
  width: 44px;
  height: 44px;
  object-fit: contain;
  display: block;
  filter: drop-shadow(0 3px 6px rgba(0, 0, 0, 0.45));
  transition: transform 0.25s ease;
}

.tile-slot:hover .official-logo-img {
  transform: scale(1.12);
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
    height: 450px;
    transform: scale(0.85);
  }
  .callout-desc {
    display: none;
  }
}
</style>
