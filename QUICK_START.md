# Quick Start Guide - SmartUI Visual Testing

## ✅ Your Credentials (Verified)

```
PROJECT_TOKEN: 2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
LT_USERNAME: samuelemediong45
LT_ACCESS_KEY: LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB
```

All credentials are correctly set in `run-smartui-tests.bat` ✅

## 🚀 Quick Start (3 Steps)

### Step 1: Start React App
Open a **new terminal window** and run:
```cmd
npm start
```
Wait until you see: `Local: http://localhost:3000`

### Step 2: Run SmartUI Tests
In **another terminal window**, run:
```cmd
run-smartui-tests.bat
```

Or manually:
```cmd
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
set LT_USERNAME=samuelemediong45
set LT_ACCESS_KEY=LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB
npm run test:smartui
```

### Step 3: View Results
Go to: https://smartui.lambdatest.com

---

## 📋 What Should Happen

1. **SmartUI CLI starts:**
   ```
   ✔ SmartUI started
     → listening on port 49152
   ```

2. **Build is created:**
   ```
   ✔ SmartUI build created
     → Build ID: xxxxx
   ```
   (Should NOT say "Skipped SmartUI build creation")

3. **Test runs with local browser:**
   ```
   ✓ SmartUI CLI detected - Using local Chrome browser
   ✓ Local Chrome browser started successfully
   ```

4. **Snapshots are captured:**
   ```
   ✓ SmartUI snapshot captured: Home Page - Full View
   ✓ SmartUI snapshot captured: Home Page - Scrolled View
   ✓ SmartUI snapshot captured: Home Page - Top View
   ```

5. **Build is finalized:**
   ```
   ✔ Snapshots processed
   ✔ Build finalized
   ```

---

## 🔍 Troubleshooting

### If you see "Empty PROJECT_TOKEN":

**Solution 1:** Set it manually before running:
```cmd
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
npm run test:smartui
```

**Solution 2:** Install SmartUI CLI globally (as LambdaTest recommends):
```cmd
npm install -g @lambdatest/smartui-cli
```
Then run tests again.

**Solution 3:** Use PowerShell script instead:
```powershell
.\run-smartui-tests.ps1
```

### If you see "No snapshots processed":

1. **Check React app is running:**
   - Open `http://localhost:3000` in browser
   - Should see your app

2. **Check test output:**
   - Look for "SmartUI snapshot captured" messages
   - Should see 3 snapshots

3. **Verify SmartUI CLI detected:**
   - Should see "SmartUI CLI detected" message
   - Should use local browser (not try to connect to LambdaTest cloud)

---

## 📝 Configuration Files

- ✅ `.smartui.json` - SmartUI configuration (matches LambdaTest format)
- ✅ `src/lambdatest.spec.js` - Test file with SmartUI integration
- ✅ `run-smartui-tests.bat` - Test runner with credentials
- ✅ `jest.config.js` - Jest configuration for ES modules
- ✅ `.babelrc` - Babel configuration

---

## 🎯 Expected Test Output

```
=== LambdaTest SmartUI Test Runner ===

Environment variables set
  LT_USERNAME: samuelemediong45
  PROJECT_TOKEN: 2827339#01K9ZPEJMFE...

React app is running!

=== Running SmartUI Tests ===

✔ SmartUI started
  → listening on port 49152
✔ Fetched git information
  → branch: master, commit: xxxxx, author: xxxxx
✔ SmartUI build created
  → Build ID: xxxxx

=== Environment Variables Debug ===
LT_USERNAME: ✓ Set
LT_ACCESS_KEY: ✓ Set
PROJECT_TOKEN: ✓ Set (2827339#01K9ZPEJMFE...)
APP_URL: http://localhost:3000
===================================

✓ SmartUI CLI detected - Using local Chrome browser
✓ Local Chrome browser started successfully

PASS src/lambdatest.spec.js
  UserCard on LambdaTest
    ✓ should load app and capture SmartUI snapshots (15.234s)

✓ SmartUI snapshot captured: Home Page - Full View
✓ SmartUI snapshot captured: Home Page - Scrolled View
✓ SmartUI snapshot captured: Home Page - Top View

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total

✔ Snapshots processed
✔ Build finalized
```

---

## 📚 Additional Resources

- **LambdaTest Dashboard:** https://smartui.lambdatest.com
- **Project URL:** https://smartui.lambdatest.com/builds/01K9ZPEJMFEYRM5XQ31KA2A13Q
- **Documentation:** See `LAMBDATEST_SETUP_STEPS.md` for detailed steps

---

## ✅ Checklist

Before running tests, verify:

- [x] PROJECT_TOKEN is correct: `2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing`
- [x] LT_USERNAME is correct: `samuelemediong45`
- [x] LT_ACCESS_KEY is correct: `LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB`
- [ ] React app is running on `http://localhost:3000`
- [ ] Run `run-smartui-tests.bat` to execute tests
- [ ] Check SmartUI dashboard for results

---

**You're all set!** Just start your React app and run the batch file. 🚀

