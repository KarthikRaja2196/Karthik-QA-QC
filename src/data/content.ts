export const profile = {
  name: 'Karthik Raja M',
  handle: 'karthik.qa',
  initials: 'KR',
  email: 'muthukarthikucp96@gmail.com',
  phone: '+91 81489 68330',
  phoneHref: 'tel:+918148968330',
  whatsappHref: 'https://wa.me/918148968330?text=Hi%20Karthik,%20I%20saw%20your%20QA%20Automation%20portfolio',
  location: 'Tamil Nadu, India · Remote Worldwide',
  availability: 'Available for freelance frameworks & QA consulting',
}

export const navLinks = [
  { id: 'skills', label: 'Skills' },
  { id: 'ai', label: 'AI QA Tech' },
  { id: 'code', label: 'Code Standards' },
  { id: 'services', label: 'Services' },
  { id: 'projects', label: 'Case Studies' },
  { id: 'calculator', label: 'ROI Estimator' },
  { id: 'process', label: 'Process' },
]

export const heroRoles = [
  'Playwright + TypeScript',
  'Selenium + Java + TestNG',
  'AI-Augmented Self-Healing QA',
  'CI/CD Pipeline Sharding',
]

export const heroStats = [
  { value: '6+', label: 'Years in QA automation' },
  { value: '15+', label: 'Production frameworks delivered' },
  { value: '600+', label: 'End-to-end tests automated' },
  { value: '0', label: 'Flaky tests tolerated' },
]

export const techStack = [
  'Playwright', 'Selenium WebDriver', 'TypeScript', 'Java', 'TestNG', 'ChatGPT', 'Google Cloud', 'AI Self-Healing',
  'GitHub Actions', 'Jenkins', 'Docker', 'Rest Assured', 'MCPs', 'Postman / Newman', 'LLM Test Synthesis', 'Allure Reports',
]

export interface SkillItem {
  icon: string
  title: string
  desc: string
  category: 'e2e' | 'api' | 'cicd' | 'all'
  tags: string[]
  level: string
}

export const skills: SkillItem[] = [
  {
    icon: 'TS',
    title: 'TypeScript + Playwright',
    desc: 'End-to-end and API test suites with Playwright Test, Page Object Model, fixtures, network mocking, and parallel/cross-browser execution.',
    category: 'e2e',
    tags: ['Playwright Test', 'POM Architecture', 'APIRequestContext', 'Visual Regression', 'Multi-tab & StorageState'],
    level: 'Expert · Primary Stack',
  },
  {
    icon: 'JV',
    title: 'Java + Selenium WebDriver',
    desc: 'WebDriver automation for legacy and modern web apps, built on solid OOP design, custom locator strategies, and reusable utility layers.',
    category: 'e2e',
    tags: ['Selenium WebDriver 4', 'Page Factory / POM', 'Maven', 'Cucumber BDD', 'Explicit Waits'],
    level: '6+ Years Experience',
  },
  {
    icon: 'TG',
    title: 'TestNG Orchestration',
    desc: 'Enterprise test execution with XML suites, DataProviders, custom listeners, retry analyzers, and grouped parallel execution strategies.',
    category: 'e2e',
    tags: ['DataProviders', 'IRetryAnalyzer', 'Parallel Suites', 'testng.xml Design', 'ThreadLocal Driver'],
    level: 'Advanced',
  },
  {
    icon: 'CI',
    title: 'CI/CD Pipeline Integration',
    desc: 'Wiring automation suites into continuous integration pipelines with automated sharding, HTML artifacts, and failure alerts.',
    category: 'cicd',
    tags: ['GitHub Actions Matrix', 'Jenkins Declarative', 'Allure / Extent Reports', 'Docker Runners', 'Slack Webhooks'],
    level: 'Production Grade',
  },
  {
    icon: 'API',
    title: 'API & Contract Testing',
    desc: 'Automated coverage for REST services alongside UI flows, validating JSON schemas, idempotency, and OAuth authentication.',
    category: 'api',
    tags: ['Rest Assured', 'Playwright API', 'Postman / Newman', 'JSON Schema Validation', 'JWT Auth'],
    level: 'Core Specialization',
  },
  {
    icon: 'VU',
    title: 'Vue.js & Modern SPA Aware',
    desc: 'Comfortable testing reactive Vue 3 / React SPAs — handling asynchronous component states, hydration, Pinia store state, and SPA routing.',
    category: 'all',
    tags: ['Vue 3 SPAs', 'Vite', 'Composition API', 'Async Component Resilience', 'Flake Prevention'],
    level: 'Modern Web Fluency',
  },
  {
    icon: 'AI',
    title: 'AI-Augmented & Self-Healing QA',
    desc: 'Next-generation test automation powered by AI: self-healing locators that adapt to DOM refactoring, LLM edge-case synthesis, and neural visual regression.',
    category: 'all',
    tags: ['Self-Healing Locators', 'Applitools Visual AI', 'LLM Prompt Fuzzing', 'Predictive Flake Triage', 'Playwright AI Agents'],
    level: 'Next-Gen QA Tech',
  },
]

export const aiCapabilities = [
  {
    icon: '🧠',
    tag: 'RESILIENCE',
    title: 'Self-Healing Locators',
    desc: 'When frontend code refactors button IDs or class hierarchies, AI DOM semantic analysis dynamically resolves matching elements, preventing broken CI builds.',
    metric: '94% reduction in locator maintenance',
  },
  {
    icon: '👁️',
    tag: 'COMPUTER VISION',
    title: 'Neural Visual Regression',
    desc: 'Deep learning pixel & layout inspection that filters out 1px rendering noise while pinpointing genuine overlapping elements and styling bugs.',
    metric: '0 false-positive visual alerts',
  },
  {
    icon: '⚡',
    tag: 'SYNTHETIC DATA',
    title: 'LLM Edge-Case Synthesis',
    desc: 'Automated generation of complex international payloads, boundary condition datasets, and security edge cases without tedious manual spreadsheets.',
    metric: '10x deeper test input coverage',
  },
  {
    icon: '🔮',
    tag: 'INTELLIGENCE',
    title: 'Automated Root Cause Triage',
    desc: 'Instant machine learning classification of CI failures into true regressions, transient network timeouts, or third-party API downtimes.',
    metric: '< 60s failure root-cause analysis',
  },
]

export const qualityGuarantees = [
  {
    icon: '🛡️',
    title: 'Zero Flake Guarantee',
    desc: 'No arbitrary sleep() statements. Every locator uses strict auto-waiting, dynamic polling, and deterministic assertions.',
  },
  {
    icon: '⚡',
    title: '4x Sharded CI Speed',
    desc: 'Test runs configured with parallel matrix sharding in GitHub Actions, slashing 4-hour manual regression cycles down to ~15 minutes.',
  },
  {
    icon: '📦',
    title: 'Maintainable Page Objects',
    desc: 'Clean encapsulation of selectors and interactions so developers can write new tests in minutes without breaking old ones.',
  },
  {
    icon: '📊',
    title: 'Instant Actionable Reporting',
    desc: 'Every failure automatically captures video recordings, DOM snapshots, network HAR traces, and sends Slack notifications.',
  },
]

export const services = [
  {
    num: '01',
    title: 'Test automation framework setup',
    items: [
      'Playwright + TypeScript framework from scratch',
      'Selenium + Java + TestNG framework from scratch',
      'Page Object Model, custom fixtures, config, reporting',
    ],
  },
  {
    num: '02',
    title: 'Regression suite automation',
    items: [
      'Convert manual regression packs into automated suites',
      'Cross-browser + cross-device coverage (Chromium, WebKit, Firefox)',
      'Flaky test triage and stabilization',
    ],
  },
  {
    num: '03',
    title: 'CI/CD pipeline integration',
    items: [
      'GitHub Actions / Jenkins matrix sharding',
      'Allure reports with video traces and screenshots',
      'Instant Slack / email alert triage on failure',
    ],
  },
  {
    num: '04',
    title: 'API & backend test automation',
    items: [
      'REST API automation and contract schema validation',
      'Data-driven test design with fixtures and factories',
      'Combined UI + API end-to-end smoke strategy',
    ],
  },
]

export const projects = [
  {
    title: 'E-commerce Regression Suite',
    role: 'Playwright · TypeScript · CI Matrix',
    desc: 'Rebuilt a 200+ manual test-case regression pack into a Playwright TypeScript suite with POM architecture, custom fixtures, and GitHub Actions parallel 4-worker sharding.',
    metrics: [
      { value: '92%', label: 'Coverage automated' },
      { value: '4.5h → 18m', label: 'Regression runtime' },
      { value: '0', label: 'Flaky tests in prod' },
    ],
    stack: ['Playwright', 'TypeScript', 'GitHub Actions', 'Allure', 'Docker'],
  },
  {
    title: 'Enterprise Web App Framework',
    role: 'Selenium · Java · TestNG',
    desc: 'Designed a Selenium/Java/TestNG framework with ThreadLocal drivers, data providers, custom listeners, and Extent reporting for a legacy enterprise portal with complex iframes and modals.',
    metrics: [
      { value: '350+', label: 'Automated test cases' },
      { value: '6', label: 'Browser/OS combos' },
      { value: '35%', label: 'Faster release cycle' },
    ],
    stack: ['Selenium 4', 'Java 17', 'TestNG', 'Maven', 'Jenkins'],
  },
  {
    title: 'Vue 3 SPA Test Coverage',
    role: 'Playwright · Vue 3 · RestAssured',
    desc: 'Built stable end-to-end coverage for a modern Vue 3 + Vite single-page application, handling async component state, route guards, Pinia side effects, and payment gateway callbacks.',
    metrics: [
      { value: '60+', label: 'E2E scenarios' },
      { value: '100%', label: 'Critical path coverage' },
      { value: '<1%', label: 'Test flake rate' },
    ],
    stack: ['Playwright', 'Vue 3', 'Vite', 'Pinia', 'GitHub Actions'],
  },
]

export const experienceMilestones = [
  {
    period: '2023 — PRESENT',
    role: 'Senior QA Automation Consultant & SDET',
    scope: 'Active in Industry · Remote / Worldwide',
    desc: 'Driving next-generation automation frameworks for scale-ups and high-velocity engineering teams. Architecting strict-typed Playwright + TypeScript suites, AI-assisted self-healing locators, and sharded CI/CD matrix runners.',
    highlights: ['15+ production test suites delivered', 'Average 78% reduction in regression cycle times', 'Pioneering AI-augmented QA & MCP agent workflows'],
  },
  {
    period: '2021 — 2023',
    role: 'Senior SDET / Automation Engineer',
    scope: 'Enterprise Software & Core Platforms',
    desc: 'Engineered high-throughput enterprise automation frameworks using Java + Selenium WebDriver 4 + TestNG. Built REST Assured contract validation layers and integrated automated quality gates into Jenkins pipelines.',
    highlights: ['Automated 300+ enterprise regression workflows', 'Engineered parallel test execution on Selenium Grid with zero flakiness'],
  },
  {
    period: '2018 — 2021',
    role: 'QA Automation Engineer',
    scope: 'College Graduated 2018 → Industry Kickoff',
    desc: 'Completed college in 2018 and immediately launched full-time automation engineering career. Built automated regression suites, API smoke verification, and standardized test coverage across agile delivery sprints.',
    highlights: ['Graduated college in 2018 and entered direct full-time QA automation engineering', 'Automated critical path REST APIs and cross-browser web workflows with Selenium, TestNG & Postman'],
  },
]

export const process = [
  { no: '01', title: 'Discovery & Audit', desc: 'Deep dive into your application, current test bottlenecks, and release cadence.' },
  { no: '02', title: 'Framework Architecture', desc: 'Design the stack (Playwright/Selenium), folder hierarchy, fixtures, and CI strategy.' },
  { no: '03', title: 'Iterative Implementation', desc: 'Automate high-value critical flows first, with live demos and code walkthroughs.' },
  { no: '04', title: 'CI Pipeline & Handover', desc: 'Wire into GitHub Actions, set up Allure reports, and provide full team documentation.' },
]
