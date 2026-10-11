export const profile = {
  name: 'Karthik Raja M',
  handle: 'karthik.qa',
  initials: 'KR',
  email: 'muthukarthikucp96@gmail.com',
  phone: '+91 81489 68330',
  phoneHref: 'tel:+918148968330',
}

export const navLinks = [
  { id: 'skills', label: 'Skills' },
  { id: 'services', label: 'Services' },
  { id: 'projects', label: 'Projects' },
  { id: 'process', label: 'Process' },
]

export const heroRoles = [
  'Playwright + TypeScript',
  'Selenium + Java + TestNG',
  'API & contract testing',
  'CI/CD pipeline integration',
]

export const heroStats = [
  { value: '8+', label: 'Years in QA automation' },
  { value: '15+', label: 'Automation projects' },
  { value: '600+', label: 'Test cases automated' },
]

export const techStack = [
  'Playwright', 'Selenium WebDriver', 'TypeScript', 'Java', 'TestNG', 'Cucumber BDD',
  'GitHub Actions', 'Jenkins', 'Docker', 'Rest Assured', 'Postman / Newman', 'Allure Reports',
]

export const skills = [
  {
    icon: 'TS',
    title: 'TypeScript + Playwright',
    desc: 'End-to-end and API test suites with Playwright Test, Page Object Model, fixtures, and parallel/cross-browser execution.',
    tags: ['Playwright Test', 'POM', 'API testing', 'Visual regression', 'CI parallelism'],
  },
  {
    icon: 'JV',
    title: 'Java + Selenium',
    desc: 'WebDriver automation for legacy and modern web apps, built on solid OOP design and reusable utility layers.',
    tags: ['Selenium WebDriver', 'Page Object Model', 'Maven', 'Cucumber BDD'],
  },
  {
    icon: 'TG',
    title: 'TestNG',
    desc: 'Test orchestration with suites, data providers, listeners, retry logic, and grouped/parallel execution strategies.',
    tags: ['DataProviders', 'Listeners', 'Parallel suites', 'testng.xml design'],
  },
  {
    icon: 'CI',
    title: 'CI/CD Integration',
    desc: 'Wiring automation suites into pipelines with reporting, artifacts, and failure triage baked in.',
    tags: ['GitHub Actions', 'Jenkins', 'Allure / Extent Reports', 'Dockerized runners'],
  },
  {
    icon: 'API',
    title: 'API & Contract Testing',
    desc: 'Automated coverage for REST services alongside UI flows, validating schema and business logic.',
    tags: ['APIRequestContext', 'Rest Assured', 'Postman / Newman'],
  },
  {
    icon: 'VU',
    title: 'Vue.js Aware',
    desc: 'Comfortable testing Vue 3 SPAs — component-level selectors, async state, and SPA routing edge cases.',
    tags: ['Vue 3', 'Vite', 'Composition API', 'SPA test stability'],
  },
]

export const services = [
  {
    num: '01',
    title: 'Test automation framework setup',
    items: [
      'Playwright + TypeScript framework from scratch',
      'Selenium + Java + TestNG framework from scratch',
      'Page Object Model, fixtures, config, reporting',
    ],
  },
  {
    num: '02',
    title: 'Regression suite automation',
    items: [
      'Convert manual regression packs into automated suites',
      'Cross-browser + cross-device coverage',
      'Flaky test triage and stabilisation',
    ],
  },
  {
    num: '03',
    title: 'CI/CD pipeline integration',
    items: [
      'GitHub Actions / Jenkins pipeline wiring',
      'Parallel execution + sharding',
      'Slack / email failure reporting',
    ],
  },
  {
    num: '04',
    title: 'API & backend test automation',
    items: [
      'REST API automation and contract checks',
      'Data-driven test design',
      'Combined UI + API test strategy',
    ],
  },
]

export const projects = [
  {
    title: 'E-commerce Regression Suite',
    role: 'Playwright · TypeScript',
    desc: 'Rebuilt a 200+ manual test-case regression pack into a Playwright TypeScript suite with POM architecture, fixtures, and GitHub Actions parallel sharding.',
    metrics: [
      { value: '92%', label: 'Coverage automated' },
      { value: '4.5h → 18m', label: 'Regression runtime' },
      { value: '0', label: 'Flaky tests in prod' },
    ],
    stack: ['Playwright', 'TypeScript', 'GitHub Actions', 'Allure'],
  },
  {
    title: 'Enterprise Web App Framework',
    role: 'Selenium · Java · TestNG',
    desc: 'Designed a Selenium/Java/TestNG framework with data providers, listeners, and Extent reporting for a legacy enterprise portal with heavy iframe/modal usage.',
    metrics: [
      { value: '350+', label: 'Automated test cases' },
      { value: '6', label: 'Browser/OS combos' },
      { value: '35%', label: 'Faster release cycle' },
    ],
    stack: ['Selenium', 'Java', 'TestNG', 'Maven', 'Jenkins'],
  },
  {
    title: 'Vue 3 SPA Test Coverage',
    role: 'Playwright · Vue 3',
    desc: 'Built stable end-to-end coverage for a Vue 3 + Vite single-page app, handling async component state, route guards, and Pinia store side effects.',
    metrics: [
      { value: '60+', label: 'E2E scenarios' },
      { value: '100%', label: 'Critical path coverage' },
      { value: '<2%', label: 'Test flake rate' },
    ],
    stack: ['Playwright', 'Vue 3', 'Vite', 'Pinia'],
  },
]

export const process = [
  { no: '01', title: 'Discovery call', desc: 'Understand your app, current QA gaps, and release cadence.' },
  { no: '02', title: 'Framework plan', desc: 'Propose stack, structure, and CI integration tailored to your team.' },
  { no: '03', title: 'Build & review', desc: 'Iterative delivery with working demos and code walkthroughs.' },
  { no: '04', title: 'Handover & CI', desc: 'Docs, pipeline wiring, and knowledge transfer to your team.' },
]
