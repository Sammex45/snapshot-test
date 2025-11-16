# Module Import Error Fix

## Error Fixed

**Error:** `SyntaxError: Cannot use import statement outside a module`

**Location:** `src/lambdatest.spec.js:90`

**Root Cause:** 
- `@lambdatest/selenium-driver` depends on `@lambdatest/sdk-utils` which uses ES modules
- Jest was trying to load the module at import time, causing ES module syntax errors
- The `transformIgnorePatterns` wasn't catching all nested dependencies

## Fixes Applied

### 1. ✅ Changed to Lazy Loading

**Before:**
```javascript
const { smartuiSnapshot } = require("@lambdatest/selenium-driver");
```

**After:**
```javascript
let smartuiSnapshotFn = null;

async function captureSmartUISnapshot(driver, snapshotName) {
  // Lazy load inside the function
  if (!smartuiSnapshotFn) {
    const smartuiModule = require("@lambdatest/selenium-driver");
    smartuiSnapshotFn = smartuiModule.smartuiSnapshot;
  }
  // Use the function
  await smartuiSnapshotFn(driver, snapshotName);
}
```

**Why this works:**
- Module is loaded at runtime (when function is called), not at import time
- Jest has already initialized and can handle the transformation
- Avoids top-level import issues

### 2. ✅ Updated Jest Configuration

**`jest.config.js`:**
- Kept `transformIgnorePatterns` to transform `@lambdatest` packages
- Cleared Jest cache to ensure fresh transformation

### 3. ✅ Cleared Jest Cache

```bash
npx jest --clearCache
```

This ensures Jest re-transforms all modules with the updated configuration.

## Testing the Fix

1. **Clear cache (already done):**
   ```bash
   npx jest --clearCache
   ```

2. **Run tests:**
   ```bash
   npm run test:smartui
   ```

3. **Expected result:**
   - No "Cannot use import statement" error
   - Tests should run successfully
   - Snapshots should be captured

## Verification

After running tests, you should see:
- ✅ No module import errors
- ✅ SmartUI snapshot function loads successfully
- ✅ Tests execute without syntax errors
- ✅ Snapshots are captured

## If Error Persists

If you still see the error:

1. **Check Babel is working:**
   ```bash
   npx babel --version
   ```

2. **Verify packages are installed:**
   ```bash
   npm list @babel/core @babel/preset-env babel-jest
   ```

3. **Try reinstalling:**
   ```bash
   npm install --save-dev @babel/core @babel/preset-env @babel/preset-react babel-jest
   ```

4. **Clear all caches:**
   ```bash
   npx jest --clearCache
   rm -rf node_modules/.cache
   ```

The lazy loading approach should resolve the ES module import issue! 🎉

