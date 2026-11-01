<script setup lang="ts">
import { ref } from 'vue'

interface CodeTab {
  id: 'playwright' | 'selenium' | 'ci'
  filename: string
  label: string
  lang: string
  code: string
}

const copied = ref(false)
const activeTab = ref<'playwright' | 'selenium' | 'ci'>('playwright')

const tabs: CodeTab[] = [
  {
    id: 'playwright',
    label: 'Playwright POM (TypeScript)',
    filename: 'tests/e2e/pages/checkout.page.ts',
    lang: 'typescript',
    code: `import { type Page, type Locator, expect } from '@playwright/test';

export class CheckoutPage {
  readonly page: Page;
  readonly cardInput: Locator;
  readonly expiryInput: Locator;
  readonly placeOrderBtn: Locator;
  readonly confirmationBadge: Locator;

  constructor(page: Page) {
    this.page = page;
    this.cardInput = page.getByRole('textbox', { name: /card number/i });
    this.expiryInput = page.getByPlaceholder('MM/YY');
    this.placeOrderBtn = page.getByRole('button', { name: /place order/i });
    this.confirmationBadge = page.getByTestId('order-confirmation-badge');
  }

  async submitPayment(card: string, exp: string) {
    await this.cardInput.fill(card);
    await this.expiryInput.fill(exp);
    // Auto-waits for payment processing network idle without hardcoded sleeps
    await Promise.all([
      this.page.waitForResponse(res => res.url().includes('/api/charge') && res.status() === 200),
      this.placeOrderBtn.click(),
    ]);
    await expect(this.confirmationBadge).toBeVisible({ timeout: 5000 });
  }
}`,
  },
  {
    id: 'selenium',
    label: 'Selenium + TestNG (Java)',
    filename: 'src/test/java/com/qa/base/BaseTest.java',
    lang: 'java',
    code: `package com.qa.base;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.*;

public abstract class BaseTest {
    // ThreadLocal ensures zero cross-thread pollution during 8+ parallel execution
    private static final ThreadLocal<WebDriver> driverThread = new ThreadLocal<>();

    @BeforeMethod(alwaysRun = true)
    @Parameters({"browser", "headless"})
    public void setupDriver(@Optional("chrome") String browser, @Optional("true") String headless) {
        ChromeOptions options = new ChromeOptions();
        if (Boolean.parseBoolean(headless)) {
            options.addArguments("--headless=new", "--disable-gpu", "--no-sandbox");
        }
        WebDriver driver = DriverFactory.createInstance(browser, options);
        driverThread.set(driver);
    }

    public static WebDriver getDriver() {
        return driverThread.get();
    }

    @AfterMethod(alwaysRun = true)
    public void tearDown() {
        WebDriver driver = driverThread.get();
        if (driver != null) {
            driver.quit();
            driverThread.remove();
        }
    }
}`,
  },
  {
    id: 'ci',
    label: 'GitHub Actions Matrix (YAML)',
    filename: '.github/workflows/e2e-matrix.yml',
    lang: 'yaml',
    code: `name: Playwright Parallel Regression

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    name: Shard \${{ matrix.shard }} on Ubuntu
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        shard: [1/4, 2/4, 3/4, 4/4] # 4x sharded parallel execution cuts runtime by 75%
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: 'npm'

      - name: Install dependencies & Playwright browsers
        run: |
          npm ci
          npx playwright install --with-deps chromium

      - name: Run E2E Shard
        run: npx playwright test --shard=\${{ matrix.shard }}

      - name: Upload Test Traces & Allure Report
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report-\${{ strategy.job-index }}
          path: playwright-report/
          retention-days: 14`,
  },
]

function getActiveCode() {
  return tabs.find((t) => t.id === activeTab.value)?.code || ''
}

function getActiveFilename() {
  return tabs.find((t) => t.id === activeTab.value)?.filename || ''
}

async function copyCode() {
  try {
    await navigator.clipboard.writeText(getActiveCode())
    copied.value = true
    setTimeout(() => {
      copied.value = false
    }, 2000)
  } catch (err) {
    console.warn('Copy failed:', err)
  }
}
</script>

<template>
  <div class="code-showcase-wrap reveal">
    <div class="code-box">
      <!-- Top Bar -->
      <div class="code-nav-bar">
        <div class="dots" aria-hidden="true">
          <span></span><span></span><span></span>
        </div>

        <div class="tab-list">
          <button
            v-for="t in tabs"
            :key="t.id"
            type="button"
            class="code-tab-btn mono"
            :class="{ active: activeTab === t.id }"
            @click="activeTab = t.id"
          >
            {{ t.label }}
          </button>
        </div>

        <button
          type="button"
          class="copy-btn mono"
          :title="copied ? 'Copied to clipboard' : 'Copy code snippet'"
          @click="copyCode"
        >
          <span v-if="!copied">📋 copy</span>
          <span v-else class="copied-text">✓ copied!</span>
        </button>
      </div>

      <!-- File Path Bar -->
      <div class="file-path-bar mono">
        <span class="file-icon">📄</span>
        <span class="path-text">{{ getActiveFilename() }}</span>
        <span class="tag-clean">✓ production-grade standards</span>
      </div>

      <!-- Code Content -->
      <pre class="code-pre mono"><code>{{ getActiveCode() }}</code></pre>
    </div>
  </div>
</template>

<style scoped>
.code-showcase-wrap {
  margin-top: 48px;
}

.code-box {
  background: #0f0822;
  border: 1px solid rgba(167, 139, 250, 0.28);
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 30px 80px -20px rgba(0, 0, 0, 0.8), 0 0 40px -10px rgba(109, 40, 217, 0.3);
}

.code-nav-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 18px;
  background: #180e34;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  gap: 12px;
}

.dots {
  display: flex;
  gap: 6px;
}

.dots span {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.18);
}

.dots span:nth-child(1) { background: #ef4444; }
.dots span:nth-child(2) { background: #f59e0b; }
.dots span:nth-child(3) { background: #10b981; }

.tab-list {
  display: flex;
  gap: 6px;
  overflow-x: auto;
}

.code-tab-btn {
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 12px;
  background: transparent;
  border: 1px solid transparent;
  color: var(--muted);
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.2s;
}

.code-tab-btn:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.05);
}

.code-tab-btn.active {
  background: rgba(109, 40, 217, 0.35);
  border-color: rgba(167, 139, 250, 0.4);
  color: #fff;
  font-weight: 600;
}

.copy-btn {
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #c4b5fd;
  font-size: 11.5px;
  padding: 5px 10px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  white-space: nowrap;
}

.copy-btn:hover {
  background: rgba(109, 40, 217, 0.3);
  border-color: var(--accent);
  color: #fff;
}

.copied-text {
  color: #34d399;
}

.file-path-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 20px;
  background: rgba(18, 10, 36, 0.9);
  border-bottom: 1px solid rgba(255, 255, 255, 0.04);
  font-size: 12px;
  color: #a78bfa;
}

.file-path-bar .file-icon {
  margin-right: 6px;
}

.path-text {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.tag-clean {
  font-size: 10.5px;
  color: #34d399;
  background: rgba(16, 185, 129, 0.12);
  padding: 2px 8px;
  border-radius: 4px;
  border: 1px solid rgba(16, 185, 129, 0.25);
  white-space: nowrap;
}

.code-pre {
  margin: 0;
  padding: 24px;
  overflow-x: auto;
  font-size: 13.5px;
  line-height: 1.7;
  color: #ede4ff;
  max-height: 480px;
}

@media (max-width: 680px) {
  .tag-clean {
    display: none;
  }
}
</style>
