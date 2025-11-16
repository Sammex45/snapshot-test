// SmartUI SDK Loader
// This file isolates the SmartUI SDK import to avoid ES module issues with Jest
// The require is wrapped in a function that's only called at runtime

let smartuiSnapshotFn = null;
let loadError = null;

function loadSmartUISnapshot() {
  // If already loaded successfully, return it
  if (smartuiSnapshotFn) {
    return smartuiSnapshotFn;
  }
  
  // If we've already tried and failed, throw the cached error
  if (loadError) {
    throw loadError;
  }
  
  try {
    // Direct require - Jest should transform this if transformIgnorePatterns is correct
    // This is wrapped in a function so it's only executed at runtime, not at parse time
    const smartuiModule = require("@lambdatest/selenium-driver");
    smartuiSnapshotFn = smartuiModule.smartuiSnapshot;
    
    if (!smartuiSnapshotFn || typeof smartuiSnapshotFn !== 'function') {
      throw new Error("smartuiSnapshot function not found in @lambdatest/selenium-driver");
    }
    
    return smartuiSnapshotFn;
  } catch (error) {
    // Cache the error for future calls
    loadError = error;
    
    // Provide helpful error message
    const errorMsg = error.message || String(error);
    if (errorMsg.includes("import statement") || errorMsg.includes("Cannot use import")) {
      throw new Error(
        `SmartUI SDK ES module error: ${errorMsg}\n` +
        `Solution: Ensure Jest transforms @lambdatest packages.\n` +
        `1. Check jest.config.js has: transformIgnorePatterns: ["node_modules/(?!(@lambdatest|smartui))"]\n` +
        `2. Run: npx jest --clearCache\n` +
        `3. Verify .babelrc has: ["@babel/preset-env", { "modules": "commonjs" }]`
      );
    }
    
    throw new Error(`Failed to load SmartUI SDK: ${errorMsg}`);
  }
}

module.exports = {
  loadSmartUISnapshot
};

