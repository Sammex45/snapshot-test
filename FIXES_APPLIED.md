# SmartUI Visual Regression Testing - Fixes Applied

## Summary

Based on the LambdaTest team's reference files and information from your call, I've identified and fixed several issues in your codebase.

## Issues Fixed

### 1. ✅ Fixed `.smartui.json` Viewport Format

**Problem**: Your viewports were using two-value arrays `[1920, 1080]`, but the LambdaTest reference shows single-value arrays `[1920]`.

**Reference**: `smartui-web.json` from https://github.com/hjsblogger/lambdatest-product-demo

**Fixed**:
```json
"viewports": [
  [1920],    // Changed from [1920, 1080]
  [1366],    // Changed from [1366, 768]
  [1028]     // Changed from [1024, 768]
]
```

**Additional Changes**:
- Added `safari` and `edge` browsers to match reference
- Updated `waitForTimeout` from 2000 to 1000 (matching reference)
- Changed `enableJavaScript` from `true` to `false` (matching reference)
- Removed `waitForPageRender` (not in reference)
- Removed `allowedHostnames` (set to empty array in reference)
- Removed `showRenderErrors` (not in reference)

### 2. ✅ Added Missing Babel Dependencies

**Problem**: Your `package.json` was missing Babel dependencies required for Jest to transform ES modules from `@lambdatest` packages.

**Fixed**: Added to `devDependencies`:
```json
{
  "@babel/core": "^7.23.0",
  "@babel/preset-env": "^7.23.0",
  "@babel/preset-react": "^7.23.0",
  "babel-jest": "^29.7.0"
}
```

**Why**: These are required for Jest to transform ES modules in `@lambdatest/sdk-utils` to CommonJS.

### 3. ✅ Improved SmartUI Snapshot Function Import

**Problem**: The SmartUI snapshot function import might fail if the package exports it differently than expected.

**Fixed**: Enhanced the import logic with multiple fallback patterns:
```javascript
// Try different possible export patterns
smartuiSnapshotFn = smartuiModule.smartuiSnapshot || 
                   smartuiModule.default?.smartuiSnapshot ||
                   smartuiModule.SmartUISnapshot?.smartuiSnapshot ||
                   smartuiModule;
```

**Benefits**:
- Handles different export patterns
- Better error messages showing available exports
- More robust error handling

## Next Steps

1. **Install the new dependencies**:
   ```bash
   npm install
   ```

2. **Clear Jest cache**:
   ```bash
   npx jest --clearCache
   ```

3. **Verify your environment variables are set**:
   ```bash
   # Windows PowerShell
   $env:LT_USERNAME = "samuelemediong45"
   $env:LT_ACCESS_KEY = "LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB"
   $env:PROJECT_TOKEN = "2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing"
   ```

4. **Start your React app** (in a separate terminal):
   ```bash
   npm start
   ```

5. **Run SmartUI tests**:
   ```bash
   npm run test:smartui
   ```
   Or use the batch file:
   ```bash
   run-smartui-tests.bat
   ```

## Reference Files Used

1. **YouTube Tutorial**: https://www.youtube.com/watch?v=9X-zVmS1-Ug
2. **Configuration Reference**: https://github.com/hjsblogger/lambdatest-product-demo/blob/main/smartui-web.json
3. **Java SDK Example**: https://github.com/hjsblogger/lambdatest-product-demo/blob/main/src/test/java/com/lambdatest/sdk/SmartUISDKCloud.java
4. **Visual Baseline Example**: https://github.com/hjsblogger/lambdatest-product-demo/blob/main/src/test/java/com/lambdatest/Visual_Baseline.java
5. **Visual Change Build Example**: https://github.com/hjsblogger/lambdatest-product-demo/blob/main/src/test/java/com/lambdatest/VisualChangeBuild.java

## Configuration Comparison

### Before (Your Config)
```json
{
  "web": {
    "browsers": ["chrome", "firefox"],
    "viewports": [[1920, 1080], [1366, 768], [1024, 768]]
  },
  "waitForTimeout": 2000,
  "waitForPageRender": 5000,
  "enableJavaScript": true,
  "allowedHostnames": ["localhost"],
  "smartIgnore": false,
  "showRenderErrors": false
}
```

### After (Fixed - Matches Reference)
```json
{
  "web": {
    "browsers": ["chrome", "firefox", "safari", "edge"],
    "viewports": [[1920], [1366], [1028]]
  },
  "waitForTimeout": 1000,
  "enableJavaScript": false,
  "allowedHostnames": [],
  "smartIgnore": false
}
```

## Expected Behavior

After these fixes, when you run `npm run test:smartui`:

1. SmartUI CLI should start and show: `SmartUI started listening on port 49152`
2. Tests should run and capture snapshots
3. You should see: `✓ SmartUI snapshot captured: Home Page - Full View`
4. Screenshots should appear in your SmartUI dashboard at: https://smartui.lambdatest.com

## Troubleshooting

If you still encounter errors:

1. **Check that Babel packages are installed**:
   ```bash
   npm list @babel/core @babel/preset-env babel-jest
   ```

2. **Verify SmartUI CLI is accessible**:
   ```bash
   npx smartui --version
   ```

3. **Check for module import errors**:
   - Look for "Cannot use import statement outside a module" errors
   - Verify `jest.config.js` has correct `transformIgnorePatterns`
   - Verify `.babelrc` has `"modules": "commonjs"`

4. **Verify PROJECT_TOKEN is set correctly**:
   - Format: `{username}#{projectId}#{projectName}`
   - Example: `2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing`

## Files Modified

1. `.smartui.json` - Updated to match LambdaTest reference format
2. `package.json` - Added missing Babel dependencies
3. `src/lambdatest.spec.js` - Improved SmartUI snapshot function import with better error handling

## Notes

- The viewport format change from `[1920, 1080]` to `[1920]` is based on the official LambdaTest reference
- The Babel dependencies are critical for Jest to work with ES modules in `@lambdatest` packages
- The improved import logic handles different export patterns that might exist in different versions of the SDK

