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
  { id: 'code', label: 'Code Standards' },
  { id: 'services', label: 'Services' },
  { id: 'projects', label: 'Case Studies' },
  { id: 'calculator', label: 'ROI Estimator' },
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
  { value: '15+', label: 'Production frameworks delivered' },
  { value: '600+', label: 'End-to-end tests automated' },
  { value: '0', label: 'Flaky tests tolerated' },
]

export const techStack = [
  'Playwright', 'Selenium WebDriver', 'TypeScript', 'Java', 'TestNG', 'Cucumber BDD',
  'GitHub Actions', 'Jenkins', 'Docker', 'Rest Assured', 'Postman / Newman', 'Allure Reports',
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
    level: '8+ Years Experience',
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
    period: '2022 — PRESENT',
    role: 'Senior QA Automation Consultant / Freelance',
    scope: 'Remote',
    desc: 'Architecting Playwright and Selenium frameworks for startups and scale-ups. Sharding CI/CD pipelines, stabilizing flaky legacy suites, and mentoring team members on POM design.',
    highlights: ['15+ production test suites delivered', 'Average 78% reduction in regression cycle times'],
  },
  {
    period: '2019 — 2022',
    role: 'SDET / Automation Engineer',
    scope: 'Enterprise Software',
    desc: 'Built multi-browser automation frameworks using Selenium + TestNG + Maven. Integrated test runs into Jenkins pipelines with automated Slack triage and HTML reporting.',
    highlights: ['Automated 300+ enterprise regression workflows', 'Engineered parallel test execution on Selenium Grid'],
  },
  {
    period: '2016 — 2019',
    role: 'QA Engineer',
    scope: 'Web & API Testing',
    desc: 'Executed end-to-end regression and API testing across web platforms. Transitioned teams from manual test spreadsheets to structured automated smoke testing.',
    highlights: ['Conducted comprehensive REST API contract testing', 'Standardized test case repositories and defect tracking'],
  },
]

export const process = [
  { no: '01', title: 'Discovery & Audit', desc: 'Deep dive into your application, current test bottlenecks, and release cadence.' },
  { no: '02', title: 'Framework Architecture', desc: 'Design the stack (Playwright/Selenium), folder hierarchy, fixtures, and CI strategy.' },
  { no: '03', title: 'Iterative Implementation', desc: 'Automate high-value critical flows first, with live demos and code walkthroughs.' },
  { no: '04', title: 'CI Pipeline & Handover', desc: 'Wire into GitHub Actions, set up Allure reports, and provide full team documentation.' },
]
