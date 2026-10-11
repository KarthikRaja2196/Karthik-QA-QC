<script setup lang="ts">
import { computed } from 'vue'

// mx / my are the pointer position over the hero, normalised to -1…1. The bot turns toward it.
const props = defineProps<{ mx: number; my: number }>()

const tilt = computed(() => `rotateY(${(props.mx * 18).toFixed(1)}deg) rotateX(${(-props.my * 12).toFixed(1)}deg)`)
const eyes = computed(() => `translate(${(props.mx * 8).toFixed(1)}px, ${(props.my * 6).toFixed(1)}px)`)
</script>

<template>
  <div class="stage" role="img" aria-label="3D animated avatar of Karthik as a friendly QA robot holding a passing-test badge">
    <div class="ring" aria-hidden="true"><span class="rd1"></span><span class="rd2"></span><span class="rd3"></span></div>
    <div class="bot-tilt" :style="{ transform: tilt }">
      <div class="bot">
        <div class="antenna"><span class="ant-ball"></span></div>
        <div class="head">
          <span class="ear el"></span>
          <span class="ear er"></span>
          <div class="visor">
            <div class="eyes" :style="{ transform: eyes }">
              <span class="eye"></span>
              <span class="eye"></span>
            </div>
            <span class="mouth"></span>
          </div>
        </div>
        <div class="body">
          <span class="badge mono">KR</span>
          <div class="arm al"></div>
          <div class="arm ar">
            <span class="check">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="3.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 12.5l4.5 4.5L19 7.5" /></svg>
            </span>
          </div>
        </div>
      </div>
    </div>
    <span class="shadow" aria-hidden="true"></span>
  </div>
</template>

<style scoped>
.stage { position: relative; width: 320px; height: 330px; perspective: 900px; z-index: 2; }
.bot-tilt { position: absolute; inset: 0; transform-style: preserve-3d; transition: transform 0.25s ease-out; }
.bot { position: absolute; left: 50%; top: 26px; width: 200px; margin-left: -100px; transform-style: preserve-3d; animation: botfloat 4.5s ease-in-out infinite; }
@keyframes botfloat {
  0%, 100% { transform: translateY(0) rotateY(-10deg); }
  50% { transform: translateY(-14px) rotateY(10deg); }
}
.antenna { position: relative; width: 4px; height: 32px; margin: 0 auto; background: linear-gradient(#C4B5FD, #7C3AED); border-radius: 2px; }
.ant-ball {
  position: absolute; top: -12px; left: 50%; width: 18px; height: 18px; margin-left: -9px; border-radius: 50%;
  background: radial-gradient(circle at 35% 30%, #fff, #C4B5FD 40%, var(--accent));
  box-shadow: 0 0 18px 4px var(--accent);
  animation: antglow 1.6s ease-in-out infinite;
}
@keyframes antglow { 50% { box-shadow: 0 0 32px 10px var(--accent); transform: scale(1.15); } }
.head {
  position: relative; width: 200px; height: 156px; border-radius: 52px;
  background: radial-gradient(circle at 30% 22%, #B794FF 0%, #7C3AED 38%, #4C1D95 75%, #2E1065 100%);
  box-shadow: inset -10px -14px 24px rgba(20, 5, 50, 0.55), inset 8px 10px 18px rgba(255, 255, 255, 0.25), 0 24px 50px -10px rgba(76, 29, 149, 0.8);
  transform: translateZ(30px);
}
.ear { position: absolute; top: 54px; width: 22px; height: 48px; border-radius: 12px; background: radial-gradient(circle at 40% 30%, #A78BFA, #4C1D95); box-shadow: inset -3px -4px 6px rgba(0, 0, 0, 0.35); }
.el { left: -14px; }
.er { right: -14px; }
.visor {
  position: absolute; left: 22px; right: 22px; top: 30px; height: 92px; border-radius: 40px;
  background: radial-gradient(circle at 50% 0%, #2A1650, #0D0620 70%);
  box-shadow: inset 0 4px 12px rgba(0, 0, 0, 0.8), 0 0 0 3px rgba(196, 181, 253, 0.25);
  overflow: hidden;
}
.visor::after { content: ''; position: absolute; top: 7px; left: 18px; width: 60px; height: 12px; border-radius: 10px; background: rgba(255, 255, 255, 0.14); transform: rotate(-8deg); }
.eyes { position: absolute; left: 0; right: 0; top: 20px; display: flex; justify-content: center; gap: 34px; transition: transform 0.15s ease-out; }
.eye { width: 24px; height: 30px; border-radius: 12px; background: #EDE4FF; box-shadow: 0 0 14px 3px #A78BFA; animation: blinkeye 4.2s infinite; }
@keyframes blinkeye { 0%, 46%, 50%, 100% { transform: scaleY(1); } 48% { transform: scaleY(0.1); } }
.mouth { position: absolute; left: 50%; bottom: 13px; width: 30px; height: 13px; margin-left: -15px; border: 3px solid #C4B5FD; border-top: none; border-radius: 0 0 18px 18px; box-shadow: 0 4px 10px -2px #A78BFA; }
.body {
  position: relative; width: 140px; height: 96px; margin: -8px auto 0; border-radius: 40px 40px 48px 48px;
  background: radial-gradient(circle at 30% 20%, #A78BFA, #6D28D9 45%, #3B0F80 100%);
  box-shadow: inset -8px -10px 18px rgba(20, 5, 50, 0.5), inset 6px 8px 14px rgba(255, 255, 255, 0.2);
}
.badge {
  position: absolute; left: 50%; top: 28px; width: 50px; height: 34px; margin-left: -25px; border-radius: 10px;
  background: var(--ink); color: #EDE4FF; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: 700;
  box-shadow: inset 0 0 0 2px rgba(196, 181, 253, 0.4), 0 0 14px rgba(167, 139, 250, 0.5);
}
.arm { position: absolute; top: 16px; width: 26px; height: 64px; border-radius: 14px; background: radial-gradient(circle at 40% 25%, #A78BFA, #4C1D95); transform-origin: 50% 10%; }
.al { left: -20px; transform: rotate(18deg); }
.ar { right: -20px; animation: wave 2.4s ease-in-out infinite; }
@keyframes wave { 0%, 100% { transform: rotate(-150deg); } 50% { transform: rotate(-118deg); } }
.check {
  position: absolute; bottom: -34px; left: 50%; width: 44px; height: 44px; margin-left: -22px; border-radius: 50%; background: #16A34A;
  display: flex; align-items: center; justify-content: center;
  box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.15), 0 0 22px 4px rgba(34, 197, 94, 0.6);
  animation: unwave 2.4s ease-in-out infinite;
}
@keyframes unwave { 0%, 100% { transform: rotate(150deg); } 50% { transform: rotate(118deg); } }
.shadow { position: absolute; left: 50%; bottom: 2px; width: 150px; height: 20px; margin-left: -75px; border-radius: 50%; background: radial-gradient(rgba(0, 0, 0, 0.65), transparent 70%); animation: shadowp 4.5s ease-in-out infinite; }
@keyframes shadowp { 50% { transform: scale(0.8); opacity: 0.6; } }
.ring { position: absolute; left: 50%; top: 170px; width: 300px; height: 300px; margin: -150px 0 0 -150px; border-radius: 50%; border: 1.5px solid rgba(167, 139, 250, 0.4); transform: rotateX(74deg); animation: ringspin 9s linear infinite; }
@keyframes ringspin { to { transform: rotateX(74deg) rotateZ(360deg); } }
.ring span { position: absolute; width: 12px; height: 12px; border-radius: 50%; background: #C4B5FD; box-shadow: 0 0 12px 3px var(--accent); }
.rd1 { top: -6px; left: 50%; margin-left: -6px; }
.rd2 { bottom: 20px; left: 12%; }
.rd3 { top: 45%; right: -6px; }

@media (max-width: 400px) { .stage { transform: scale(0.9); transform-origin: top center; margin-bottom: -30px; } }
@media (prefers-reduced-motion: reduce) { .bot, .ring, .ant-ball, .eye, .ar, .check, .shadow { animation: none; } }
</style>
