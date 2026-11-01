// All copy for the portfolio. Mirrors `src/data/content.ts` in the Vue site: keep the two in sync.

const profileName = 'Karthik Raja M';
const profileHandle = 'karthik.qa';
const profileInitials = 'KR';
const profileEmail = 'muthukarthikucp96@gmail.com';
const profilePhone = '+91 81489 68330';
const profilePhoneHref = 'tel:+918148968330';

class NavLink {
  const NavLink(this.id, this.label);
  final String id;
  final String label;
}

class Stat {
  const Stat(this.value, this.label);
  final String value;
  final String label;
}

class Skill {
  const Skill(this.icon, this.title, this.desc, this.tags);
  final String icon;
  final String title;
  final String desc;
  final List<String> tags;
}

class Service {
  const Service(this.num, this.title, this.items);
  final String num;
  final String title;
  final List<String> items;
}

class Project {
  const Project(this.title, this.role, this.desc, this.metrics, this.stack);
  final String title;
  final String role;
  final String desc;
  final List<Stat> metrics;
  final List<String> stack;
}

class Step {
  const Step(this.no, this.title, this.desc);
  final String no;
  final String title;
  final String desc;
}

const navLinks = [
  NavLink('skills', 'Skills'),
  NavLink('services', 'Services'),
  NavLink('projects', 'Projects'),
  NavLink('process', 'Process'),
];

const heroRoles = [
  'Playwright + TypeScript',
  'Selenium + Java + TestNG',
  'API & contract testing',
  'CI/CD pipeline integration',
];

const heroStats = [
  Stat('8+', 'Years in QA automation'),
  Stat('15+', 'Automation projects'),
  Stat('600+', 'Test cases automated'),
];

const techStack = [
  'Playwright', 'Selenium WebDriver', 'TypeScript', 'Java', 'TestNG', 'Cucumber BDD',
  'GitHub Actions', 'Jenkins', 'Docker', 'Rest Assured', 'Postman / Newman', 'Allure Reports',
];

const skills = [
  Skill(
    'TS',
    'TypeScript + Playwright',
    'End-to-end and API test suites with Playwright Test, Page Object Model, fixtures, and parallel/cross-browser execution.',
    ['Playwright Test', 'POM', 'API testing', 'Visual regression', 'CI parallelism'],
  ),
  Skill(
    'JV',
    'Java + Selenium',
    'WebDriver automation for legacy and modern web apps, built on solid OOP design and reusable utility layers.',
    ['Selenium WebDriver', 'Page Object Model', 'Maven', 'Cucumber BDD'],
  ),
  Skill(
    'TG',
    'TestNG',
    'Test orchestration with suites, data providers, listeners, retry logic, and grouped/parallel execution strategies.',
    ['DataProviders', 'Listeners', 'Parallel suites', 'testng.xml design'],
  ),
  Skill(
    'CI',
    'CI/CD Integration',
    'Wiring automation suites into pipelines with reporting, artifacts, and failure triage baked in.',
    ['GitHub Actions', 'Jenkins', 'Allure / Extent Reports', 'Dockerized runners'],
  ),
  Skill(
    'API',
    'API & Contract Testing',
    'Automated coverage for REST services alongside UI flows, validating schema and business logic.',
    ['APIRequestContext', 'Rest Assured', 'Postman / Newman'],
  ),
  Skill(
    'FL',
    'Flutter & Vue Aware',
    'Comfortable testing Vue 3 SPAs and Flutter apps: component-level selectors, async state, and routing edge cases.',
    ['Vue 3', 'Vite', 'Flutter', 'SPA test stability'],
  ),
];

const services = [
  Service('01', 'Test automation framework setup', [
    'Playwright + TypeScript framework from scratch',
    'Selenium + Java + TestNG framework from scratch',
    'Page Object Model, fixtures, config, reporting',
  ]),
  Service('02', 'Regression suite automation', [
    'Convert manual regression packs into automated suites',
    'Cross-browser + cross-device coverage',
    'Flaky test triage and stabilisation',
  ]),
  Service('03', 'CI/CD pipeline integration', [
    'GitHub Actions / Jenkins pipeline wiring',
    'Parallel execution + sharding',
    'Slack / email failure reporting',
  ]),
  Service('04', 'API & backend test automation', [
    'REST API automation and contract checks',
    'Data-driven test design',
    'Combined UI + API test strategy',
  ]),
];

const projects = [
  Project(
    'E-commerce Regression Suite',
    'Playwright · TypeScript',
    'Rebuilt a 200+ manual test-case regression pack into a Playwright TypeScript suite with POM architecture, fixtures, and GitHub Actions parallel sharding.',
    [
      Stat('92%', 'Coverage automated'),
      Stat('4.5h → 18m', 'Regression runtime'),
      Stat('0', 'Flaky tests in prod'),
    ],
    ['Playwright', 'TypeScript', 'GitHub Actions', 'Allure'],
  ),
  Project(
    'Enterprise Web App Framework',
    'Selenium · Java · TestNG',
    'Designed a Selenium/Java/TestNG framework with data providers, listeners, and Extent reporting for a legacy enterprise portal with heavy iframe/modal usage.',
    [
      Stat('350+', 'Automated test cases'),
      Stat('6', 'Browser/OS combos'),
      Stat('35%', 'Faster release cycle'),
    ],
    ['Selenium', 'Java', 'TestNG', 'Maven', 'Jenkins'],
  ),
  Project(
    'Vue 3 SPA Test Coverage',
    'Playwright · Vue 3',
    'Built stable end-to-end coverage for a Vue 3 + Vite single-page app, handling async component state, route guards, and Pinia store side effects.',
    [
      Stat('60+', 'E2E scenarios'),
      Stat('100%', 'Critical path coverage'),
      Stat('<2%', 'Test flake rate'),
    ],
    ['Playwright', 'Vue 3', 'Vite', 'Pinia'],
  ),
];

const processSteps = [
  Step('01', 'Discovery call', 'Understand your app, current QA gaps, and release cadence.'),
  Step('02', 'Framework plan', 'Propose stack, structure, and CI integration tailored to your team.'),
  Step('03', 'Build & review', 'Iterative delivery with working demos and code walkthroughs.'),
  Step('04', 'Handover & CI', 'Docs, pipeline wiring, and knowledge transfer to your team.'),
];

/// Illustrative output only: it demonstrates the style of reporting, not a real run.
const sampleTests = [
  ('checkout › guest can place an order', '1.8s'),
  ('auth › login with SSO redirects home', '0.9s'),
  ('cart › coupon applies 10% discount', '1.2s'),
  ('api › GET /orders matches schema', '0.3s'),
  ('search › filters persist on reload', '1.4s'),
  ('profile › address form validation', '0.7s'),
  ('payments › 3DS challenge succeeds', '2.1s'),
  ('visual › home page matches baseline', '1.1s'),
];
