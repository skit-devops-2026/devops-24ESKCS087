import { chromium } from "playwright";
import { mkdir } from "node:fs/promises";
import { dirname } from "node:path";

const rawUrl = process.argv[2];
const outputPath = process.argv[3] ?? "docs/deployment-screenshot.png";
if (!rawUrl) throw new Error("Usage: node capture-live-site.mjs <site-url> [output-path]");

const siteUrl = new URL(rawUrl);
if (!siteUrl.pathname.endsWith("/")) siteUrl.pathname += "/";
const healthUrl = new URL("health", siteUrl).href;
const browser = await chromium.launch({ headless: true });
const page = await browser.newPage({ viewport: { width: 1440, height: 1000 }, deviceScaleFactor: 1 });
let verified = false;
let lastError;

for (let attempt = 1; attempt <= 18; attempt += 1) {
  try {
    const response = await page.goto(siteUrl.href, { waitUntil: "domcontentloaded", timeout: 30000 });
    if (!response || !response.ok()) throw new Error(`Site returned HTTP ${response?.status() ?? "no response"}`);
    const body = await page.locator("body").innerText();
    if (!body.includes("Pupil")) throw new Error("The deployed page did not contain expected PUPIL content");
    const healthResponse = await page.request.get(healthUrl, { timeout: 15000 });
    const healthBody = await healthResponse.text();
    if (!healthResponse.ok() || !healthBody.includes('"commit"')) throw new Error(`Health endpoint failed: HTTP ${healthResponse.status()} ${healthBody}`);
    verified = true;
    break;
  } catch (error) {
    lastError = error;
    if (attempt === 18) break;
    console.log(`Deployment not ready yet (attempt ${attempt}/18): ${error.message}`);
    await new Promise(resolve => setTimeout(resolve, 10000));
  }
}

if (!verified) {
  await browser.close();
  throw lastError ?? new Error("Could not verify the deployed website");
}
await mkdir(dirname(outputPath), { recursive: true });
await page.screenshot({ path: outputPath, fullPage: true });
await browser.close();
console.log(`Verified live website and health endpoint; screenshot saved to ${outputPath}`);