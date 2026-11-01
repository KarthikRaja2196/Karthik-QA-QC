<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from 'vue'

const canvasRef = ref<HTMLCanvasElement | null>(null)
let animationId = 0

interface Particle {
  x: number
  y: number
  vx: number
  vy: number
  radius: number
  color: string
}

onMounted(() => {
  const canvas = canvasRef.value
  if (!canvas) return
  const ctx = canvas.getContext('2d')
  if (!ctx) return

  let width = (canvas.width = canvas.parentElement?.clientWidth || window.innerWidth)
  let height = (canvas.height = canvas.parentElement?.clientHeight || window.innerHeight)

  function resize() {
    if (!canvas) return
    width = canvas.width = canvas.parentElement?.clientWidth || window.innerWidth
    height = canvas.height = canvas.parentElement?.clientHeight || window.innerHeight
  }
  window.addEventListener('resize', resize)

  const numParticles = Math.min(48, Math.floor((width * height) / 22000))
  const particles: Particle[] = []
  const colors = [
    'rgba(167, 139, 250, 0.7)', // Purple
    'rgba(56, 189, 248, 0.65)', // Cyan
    'rgba(192, 38, 211, 0.55)', // Magenta
  ]

  for (let i = 0; i < numParticles; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height,
      vx: (Math.random() - 0.5) * 0.45,
      vy: (Math.random() - 0.5) * 0.45,
      radius: Math.random() * 2 + 1.2,
      color: colors[Math.floor(Math.random() * colors.length)],
    })
  }

  function draw() {
    if (!ctx) return
    ctx.clearRect(0, 0, width, height)

    // Draw synaptic connection lines between nearby neural nodes
    for (let i = 0; i < particles.length; i++) {
      for (let j = i + 1; j < particles.length; j++) {
        const dx = particles[i].x - particles[j].x
        const dy = particles[i].y - particles[j].y
        const dist = Math.sqrt(dx * dx + dy * dy)

        if (dist < 130) {
          const alpha = (1 - dist / 130) * 0.22
          ctx.beginPath()
          ctx.moveTo(particles[i].x, particles[i].y)
          ctx.lineTo(particles[j].x, particles[j].y)
          ctx.strokeStyle = `rgba(167, 139, 250, ${alpha})`
          ctx.lineWidth = 1
          ctx.stroke()
        }
      }
    }

    // Draw neural nodes with soft glow
    for (const p of particles) {
      p.x += p.vx
      p.y += p.vy

      if (p.x < 0 || p.x > width) p.vx *= -1
      if (p.y < 0 || p.y > height) p.vy *= -1

      ctx.beginPath()
      ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2)
      ctx.fillStyle = p.color
      ctx.shadowBlur = 8
      ctx.shadowColor = p.color
      ctx.fill()
      ctx.shadowBlur = 0
    }

    animationId = requestAnimationFrame(draw)
  }

  draw()

  onBeforeUnmount(() => {
    cancelAnimationFrame(animationId)
    window.removeEventListener('resize', resize)
  })
})
</script>

<template>
  <canvas ref="canvasRef" class="neural-canvas" aria-hidden="true"></canvas>
</template>

<style scoped>
.neural-canvas {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
  opacity: 0.65;
  -webkit-mask-image: radial-gradient(circle at 50% 50%, #000 30%, transparent 85%);
  mask-image: radial-gradient(circle at 50% 50%, #000 30%, transparent 85%);
}
</style>
