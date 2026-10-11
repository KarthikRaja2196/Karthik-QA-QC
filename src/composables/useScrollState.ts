import { onBeforeUnmount, onMounted, ref } from 'vue'

/** Scrollspy: reports which of the given section ids is currently most in view. */
export function useActiveSection(ids: string[]) {
  const activeId = ref('')
  let observer: IntersectionObserver | null = null

  onMounted(() => {
    observer = new IntersectionObserver(
      (entries) => {
        const visible = entries.filter((e) => e.isIntersecting)
        if (visible.length > 0) {
          visible.sort((a, b) => b.intersectionRatio - a.intersectionRatio)
          activeId.value = visible[0].target.id
        }
      },
      { rootMargin: '-45% 0px -45% 0px', threshold: [0, 0.25, 0.5, 0.75, 1] },
    )
    for (const id of ids) {
      const el = document.getElementById(id)
      if (el) observer.observe(el)
    }
  })
  onBeforeUnmount(() => observer?.disconnect())

  return { activeId }
}
