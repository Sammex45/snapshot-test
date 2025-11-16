# LambdaTest SmartUI Setup - Following Official Steps

Based on the LambdaTest SmartUI onboarding page, here are the exact steps to follow:

## Your Credentials (Verified ✅)

```
PROJECT_TOKEN: 2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
LT_ACCESS_KEY: LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB
LT_USERNAME: samuelemediong45
```

## Official LambdaTest Steps

### Step 1: Install SmartUI CLI Globally

```bash
npm install -g @lambdatest/smartui-cli
```

**Note:** Your setup uses `npx smartui` which works, but installing globally ensures it's always available.

### Step 2: Create URL Configuration (Optional - for static URL testing)

```bash
smartui config:create-web-static urls.json
```

**Note:** This is for static URL testing. Your setup uses Jest tests, so this step is optional.

### Step 3: Configure Project Token

**For Windows CMD:**
```cmd
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
```

**For PowerShell:**
```powershell
$env:PROJECT_TOKEN="2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing"
```

**For MacOS/Linux:**
```bash
export PROJECT_TOKEN="2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing"
```

✅ **Already set in `run-smartui-tests.bat`**

### Step 4: Create SmartUI Configuration File

**Official command:**
```bash
smartui config:create smartui-web.json
```

**Your current setup:**
- Uses `.smartui.json` (works the same way)
- Already configured with correct settings

### Step 5: Execute SmartUI Tests

**Official command (for static URLs):**
```bash
smartui capture urls.json --config smartui-web.json
```

**Your setup (Jest tests with SDK):**
```bash
npm run test:smartui
```

Which runs:
```bash
npx smartui --config .smartui.json exec -- jest src/lambdatest.spec.js
```

## Verification Checklist

- [x] PROJECT_TOKEN is set correctly: `2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing`
- [x] LT_ACCESS_KEY is set: `LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB`
- [x] LT_USERNAME is set: `samuelemediong45`
- [x] `.smartui.json` configuration file exists
- [x] SmartUI CLI is installed (via npx or globally)
- [ ] React app is running on `http://localhost:3000`
- [ ] Tests run successfully with snapshots

## Quick Start Commands

### Option 1: Use Batch File (Recommended)
```cmd
run-smartui-tests.bat
```

### Option 2: Manual Steps
```cmd
REM 1. Set environment variables
set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
set LT_USERNAME=samuelemediong45
set LT_ACCESS_KEY=LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB

REM 2. Start React app (in separate terminal)
npm start

REM 3. Run SmartUI tests (in another terminal)
npm run test:smartui
```

## Expected Output

When everything is working correctly, you should see:

```
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
✓ SmartUI snapshot captured: Home Page - Full View
✓ SmartUI snapshot captured: Home Page - Scrolled View
✓ SmartUI snapshot captured: Home Page - Top View
✔ Snapshots processed
✔ Build finalized
```

## Troubleshooting

### If PROJECT_TOKEN is still not detected:

1. **Verify it's set in the terminal where you run tests:**
   ```cmd
   echo %PROJECT_TOKEN%
   ```
   Should show: `2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing`

2. **Set it manually before running:**
   ```cmd
   set PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
   npm run test:smartui
   ```

3. **Check SmartUI CLI output:**
   - Should NOT say "Empty PROJECT_TOKEN"
   - Should say "SmartUI build created" instead of "Skipped SmartUI build creation"

### If snapshots are still not processed:

1. **Verify React app is running:**
   - Open `http://localhost:3000` in browser
   - Should see your React app

2. **Check test output:**
   - Look for "SmartUI snapshot captured" messages
   - Should see 3 snapshots captured

3. **Verify SmartUI CLI is running:**
   - Should see "SmartUI started listening on port 49152"
   - Test should detect it and use local browser

## Next Steps

1. ✅ Credentials verified
2. ✅ Configuration files ready
3. ⏭️ Run `run-smartui-tests.bat` to test
4. ⏭️ Check SmartUI dashboard for results

