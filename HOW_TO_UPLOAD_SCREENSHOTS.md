# How to Upload Screenshots to SmartUI Dashboard

## ⚠️ IMPORTANT: Screenshots Upload AUTOMATICALLY

**There is NO manual upload button.** Screenshots are automatically uploaded to your SmartUI dashboard when you run tests with SmartUI CLI.

## Steps to Get Screenshots in Your Dashboard:

### Step 1: Make Sure React App is Running
Open a **NEW terminal** and run:
```cmd
npm start
```
Wait until you see: `Local: http://localhost:3000`

### Step 2: Run SmartUI Tests
In **another terminal**, run:
```cmd
run-smartui-tests.bat
```

Or manually:
```cmd
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
npm run test:smartui
```

### Step 3: Wait for Tests to Complete
You should see:
- ✓ SmartUI started
- ✓ SmartUI build created
- ✓ Tests running
- ✓ SmartUI snapshot captured messages
- ✓ Build finalized

### Step 4: Check Your Dashboard
1. Go to: https://smartui.lambdatest.com
2. Click on your project: **SmartUI Visual Testing**
3. Click on the latest build (the one at the top with "Updated 0 secs ago")
4. Screenshots should appear automatically!

## What You Should See:

When tests run successfully, you'll see in the terminal:
```
✓ SmartUI snapshot captured: Home Page - Full View
✓ SmartUI snapshot captured: Home Page - Scrolled View
✓ SmartUI snapshot captured: Home Page - Top View
```

Then in your dashboard, you'll see:
- **3 screenshots** with those names
- Screenshots appear in the "Screenshots" tab
- You can compare them, approve/reject, etc.

## Troubleshooting:

### If Screenshots Don't Appear:

1. **Check if tests completed successfully**
   - Look for "Test Suites: 1 passed" in terminal
   - Look for "Build finalized" message

2. **Check if SmartUI snapshots were captured**
   - Look for "SmartUI snapshot captured" messages
   - If you see "SmartUI snapshot failed", there's an error

3. **Refresh the dashboard**
   - Click the refresh button in the dashboard
   - Or refresh the browser page

4. **Check the build**
   - Make sure you're looking at the correct build
   - Check the build ID matches what you see in terminal

## Quick Test:

Run this command to test everything:
```cmd
run-smartui-tests.bat
```

Then immediately check your dashboard - screenshots should appear within seconds!

