# SmartUI Setup Documentation & Troubleshooting Guide

## Table of Contents

1. [Complete Setup Overview](#complete-setup-overview)
2. [Why SmartUI Snapshots Are Failing](#why-smartui-snapshots-are-failing)
3. [Step-by-Step Setup Process](#step-by-step-setup-process)
4. [Configuration Files Explained](#configuration-files-explained)
5. [Troubleshooting Guide](#troubleshooting-guide)

---

## Complete Setup Overview

### What Was Set Up

1. **SmartUI Configuration (`.smartui.json`)**

   - Created with `npx smartui config:create .smartui.json`
   - Configured for Chrome and Firefox browsers
   - Viewports: 1920x1080, 1366x768, 1024x768
   - Enabled JavaScript support
   - Added localhost to allowed hostnames

2. **Test File (`src/lambdatest.spec.js`)**

   - Integrated SmartUI snapshot capture function
   - Uses local Chrome browser when `PROJECT_TOKEN` is set
   - Captures 3 snapshots: Full View, Scrolled View, Top View
   - Includes error handling and retry logic

3. **Jest Configuration (`jest.config.js`)**

   - Configured to handle ES modules from `@lambdatest` packages
   - Added `transformIgnorePatterns` to transform LambdaTest packages
   - Added `extensionsToTreatAsEsm` for ES module support

4. **Babel Configuration (`.babelrc`)**

   - Configured to output CommonJS modules
   - Includes React and ES6+ presets

5. **Package Scripts (`package.json`)**

   - Added `test:smartui` script to run tests with SmartUI CLI
   - Added helper scripts for running tests

6. **Environment Variables**
   - `LT_USERNAME`: LambdaTest username
   - `LT_ACCESS_KEY`: LambdaTest access key
   - `PROJECT_TOKEN`: SmartUI project token

---

## Why SmartUI Snapshots Are Failing

### Root Cause Analysis

The SmartUI snapshots are failing due to a **module system mismatch** between:

- **Jest** (CommonJS environment)
- **@lambdatest/selenium-driver** (CommonJS package)
- **@lambdatest/sdk-utils** (ES Module dependency)

### The Error Chain

1. **Primary Issue**: When Jest tries to load `@lambdatest/selenium-driver`, it internally requires `@lambdatest/sdk-utils`
2. **Secondary Issue**: `@lambdatest/sdk-utils` uses ES modules (`import/export`)
3. **Result**: Jest throws "Cannot use import statement outside a module"

### Why This Happens

```
Test File (CommonJS)
  ↓ requires
@lambdatest/selenium-driver (CommonJS)
  ↓ requires
@lambdatest/sdk-utils (ES Module) - ERROR HERE
  ↓ uses
axios (ES Module)
```

Jest's default behavior is to **ignore** `node_modules` and not transform them. However, ES modules in `node_modules` need to be transformed to CommonJS for Jest to work.

### Current Status

**Fixed**: Jest configuration updated to transform `@lambdatest` packages
**Fixed**: Babel configured to output CommonJS
**May Still Fail**: If Babel packages aren't properly installed or if there are other ES module dependencies

---

## Step-by-Step Setup Process

### Step 1: Install Dependencies

```bash
npm install --save-dev @babel/preset-env @babel/preset-react babel-jest @babel/core
```

Required for Jest to transform ES modules to CommonJS.

### Step 2: Configure Jest (`jest.config.js`)

```javascript
module.exports = {
  testEnvironment: "jsdom",
  setupFilesAfterEnv: ["<rootDir>/src/setupTests.js"],
  moduleNameMapper: {
    "\\.(css|less|scss|sass)$": "identity-obj-proxy",
    "\\.(jpg|jpeg|png|gif|svg)$": "<rootDir>/__mocks__/fileMock.js",
  },
  transform: {
    "^.+\\.(js|jsx)$": "babel-jest",
  },
  // KEY FIX: Transform ES modules from LambdaTest packages
  transformIgnorePatterns: ["node_modules/(?!(@lambdatest|smartui)/)"],
  extensionsToTreatAsEsm: [".js"],
  testPathIgnorePatterns: ["/node_modules/"],
};
```

**Key Configuration**:

- `transformIgnorePatterns`: Jest transforms `@lambdatest` packages instead of ignoring them
- `extensionsToTreatAsEsm`: Treats `.js` files as ES modules when needed
- `transform`: Uses Babel to transform code

### Step 3: Configure Babel (`.babelrc`)

```json
{
  "presets": [
    ["@babel/preset-env", { "modules": "commonjs" }],
    "@babel/preset-react"
  ]
}
```

**Key Configuration**:

- `"modules": "commonjs"`: Forces Babel to output CommonJS (required for Jest)
- Without this, Babel may output ES modules which Jest cannot handle

### Step 4: SmartUI Test Implementation

The test file uses a local browser when `PROJECT_TOKEN` is set:

```javascript
// When PROJECT_TOKEN is set, use local Chrome (SmartUI mode)
if (projectToken) {
  const options = new chrome.Options();
  options.addArguments("--headless=new");
  driver = await new Builder()
    .forBrowser("chrome")
    .setChromeOptions(options)
    .build();
}
```

**Local Browser Benefits**:

- Avoids network connectivity issues with LambdaTest hub
- SmartUI CLI can capture screenshots from local browsers
- Faster execution
- No DNS/network problems

### Step 5: SmartUI Snapshot Function

```javascript
async function captureSmartUISnapshot(driver, snapshotName) {
  try {
    // Lazy load the SmartUI snapshot function
    if (!smartuiSnapshotFn) {
      const smartuiModule = require("@lambdatest/selenium-driver");
      smartuiSnapshotFn = smartuiModule.smartuiSnapshot;
    }

    await smartuiSnapshotFn(driver, snapshotName);
    console.log(`SmartUI snapshot captured: ${snapshotName}`);
  } catch (error) {
    console.warn(`SmartUI snapshot failed: ${error.message}`);
  }
}
```

**Process**:

1. Lazy loads the `smartuiSnapshot` function from `@lambdatest/selenium-driver`
2. Calls the function with the driver and snapshot name
3. SmartUI SDK communicates with SmartUI CLI (running on port 49152)
4. Screenshot is captured and uploaded to SmartUI dashboard

---

## Configuration Files Explained

### `.smartui.json`

```json
{
  "web": {
    "browsers": ["chrome", "firefox"],
    "viewports": [
      [1920, 1080],
      [1366, 768],
      [1024, 768]
    ]
  },
  "waitForTimeout": 2000,
  "waitForPageRender": 5000,
  "enableJavaScript": true,
  "allowedHostnames": ["localhost"]
}
```

Defines which browsers and viewports SmartUI CLI uses for screenshots.

### `jest.config.js`

Configures Jest to:

- Transform ES modules from `@lambdatest` packages
- Handle CSS and image imports
- Use jsdom for React component testing

### `.babelrc`

Configures Babel to:

- Transform modern JavaScript to CommonJS
- Handle React JSX syntax
- Ensure compatibility with Jest

### `src/lambdatest.spec.js`

- Tests the React app on LambdaTest (or local browser)
- Captures SmartUI snapshots at key points
- Handles errors gracefully

---

## Troubleshooting Guide

### Issue 1: "Cannot use import statement outside a module"

**Symptoms**:

```
Failed to require SmartUI SDK: Cannot use import statement outside a module
```

**Root Cause**: Jest is trying to load ES modules without transforming them.

**Solution**:

1. Verify `jest.config.js` has correct `transformIgnorePatterns`:

   ```javascript
   transformIgnorePatterns: [
     "node_modules/(?!(@lambdatest|smartui)/)",
   ],
   ```

2. Verify `.babelrc` has `"modules": "commonjs"`:

   ```json
   ["@babel/preset-env", { "modules": "commonjs" }]
   ```

3. Install Babel packages:

   ```bash
   npm install --save-dev @babel/preset-env @babel/preset-react babel-jest @babel/core
   ```

4. Clear Jest cache:
   ```bash
   npx jest --clearCache
   ```

### Issue 2: "SmartUI snapshot failed: Cannot find SmartUI server"

**Symptoms**:

```
SmartUI snapshot failed: Cannot find SmartUI server
```

**Root Cause**: SmartUI CLI is not running or not accessible.

**Solution**:

1. Make sure you're running tests with SmartUI CLI:

   ```bash
   npm run test:smartui
   # NOT: npm test
   ```

2. Check that SmartUI CLI started:

   ```
   SmartUI started
   listening on port 49152
   ```

3. Verify `PROJECT_TOKEN` is set:
   ```bash
   echo $PROJECT_TOKEN  # Should show your token
   ```

### Issue 3: "ENOTFOUND hub.lambdatest.com"

**Symptoms**:

```
ENOTFOUND getaddrinfo ENOTFOUND hub.lambdatest.com
```

**Root Cause**: Network/DNS issue connecting to LambdaTest hub.

**Solution**:

- Code now uses local browser when `PROJECT_TOKEN` is set
- Local browser avoids network connectivity issues
- SmartUI CLI captures from local browser

### Issue 4: "No Screenshots found" in Dashboard

**Symptoms**: Dashboard shows builds but no screenshots.

**Root Cause**: Screenshots weren't captured or uploaded.

**Solution**:

1. Check test output for "SmartUI snapshot captured" messages
2. Verify tests completed successfully (not just passed, but actually ran)
3. Check that SmartUI CLI finalized the build:
   ```
   Build finalized
   ```
4. Refresh the dashboard and check the latest build
5. Make sure you're looking at the correct build (check build ID)

### Issue 5: Tests Pass But No Snapshots

**Symptoms**: Tests pass but SmartUI snapshots don't appear.

**Possible Causes**:

1. **SmartUI SDK not loaded**:

   - Check for "Failed to require SmartUI SDK" errors
   - Verify `@lambdatest/selenium-driver` is installed: `npm list @lambdatest/selenium-driver`

2. **SmartUI CLI not running**:

   - Must use `npm run test:smartui` (not `npm test`)
   - Should see "SmartUI started" message

3. **PROJECT_TOKEN not set**:

   - Verify environment variable is set
   - Check in test output if it's being used

4. **Local browser not starting**:
   - Check for Chrome/ChromeDriver errors
   - Verify Chrome is installed
   - Check if headless mode is working

---

## How SmartUI Works

### Architecture

```
Your Test
  ↓ calls
smartuiSnapshot(driver, "name")
  ↓ uses
@lambdatest/selenium-driver SDK
  ↓ communicates with
SmartUI CLI (localhost:49152)
  ↓ uploads to
SmartUI Dashboard (smartui.lambdatest.com)
```

### Flow

1. **Test Execution**: `npm run test:smartui` starts SmartUI CLI
2. **CLI Startup**: SmartUI CLI authenticates and starts local server (port 49152)
3. **Build Creation**: SmartUI creates a build in the dashboard
4. **Test Runs**: Jest runs your tests
5. **Snapshot Capture**: When `smartuiSnapshot()` is called:
   - SDK serializes the DOM
   - Sends it to SmartUI CLI
   - CLI captures screenshot
   - Uploads to dashboard
6. **Build Finalization**: After tests complete, SmartUI finalizes the build

### Why Local Browser?

When `PROJECT_TOKEN` is set, the code uses a local Chrome browser because:

- No network connectivity required
- Faster execution
- SmartUI CLI can capture from local browsers
- Avoids DNS/firewall issues
- Works offline (except for upload)

---

## Verification Checklist

Use this checklist to verify your setup:

- [ ] `.smartui.json` exists and is configured
- [ ] `jest.config.js` has `transformIgnorePatterns` for `@lambdatest`
- [ ] `.babelrc` has `"modules": "commonjs"`
- [ ] Babel packages are installed
- [ ] `PROJECT_TOKEN` environment variable is set
- [ ] React app is running on `http://localhost:3000`
- [ ] Running tests with `npm run test:smartui` (not `npm test`)
- [ ] SmartUI CLI shows "SmartUI started" message
- [ ] Tests show "SmartUI snapshot captured" messages
- [ ] Dashboard shows screenshots after test completion

---

## Quick Fix Commands

If snapshots are still failing, run these in order:

```bash
# 1. Install/update Babel packages
npm install --save-dev @babel/preset-env @babel/preset-react babel-jest @babel/core

# 2. Clear Jest cache
npx jest --clearCache

# 3. Verify SmartUI CLI is installed
npx smartui --version

# 4. Set environment variables
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing

# 5. Run tests
npm run test:smartui
```

---

## Summary

### What Was Set Up

- SmartUI configuration file
- Jest configuration for ES modules
- Babel configuration for CommonJS
- Test file with SmartUI integration
- Local browser support
- Error handling and retry logic

### Why Snapshots Fail

- **Module system mismatch**: ES modules in `@lambdatest/sdk-utils` not being transformed
- **Jest configuration**: `transformIgnorePatterns` not including all needed packages
- **Babel configuration**: Not forcing CommonJS output

### Current Fixes Applied

- Updated `transformIgnorePatterns` to include `@lambdatest` packages
- Added `extensionsToTreatAsEsm` to Jest config
- Updated Babel to output CommonJS modules
- Switched to local browser to avoid network issues

### Next Steps

1. Run `npm install --save-dev @babel/preset-env @babel/preset-react babel-jest @babel/core`
2. Clear Jest cache: `npx jest --clearCache`
3. Run tests: `run-smartui-tests.bat`
4. Check dashboard for screenshots

---

## Additional Resources

- [LambdaTest SmartUI Docs](https://www.lambdatest.com/support/docs/smartui-running-your-first-project/)
- [Jest ES Modules Guide](https://jestjs.io/docs/ecmascript-modules)
- [Babel Configuration](https://babeljs.io/docs/en/configuration)
