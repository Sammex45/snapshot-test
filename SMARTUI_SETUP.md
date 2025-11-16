# LambdaTest SmartUI Setup Guide

This guide will help you set up and run SmartUI visual regression tests on LambdaTest platform.

## Prerequisites

1. **LambdaTest Account**: You need access to LambdaTest SmartUI. If you don't have access, contact Saniya Gazala or request access through LambdaTest.

2. **Node.js**: Ensure you have Node.js v20.3 or above installed (required for SmartUI CLI v4.x.x)

3. **React App Running**: Your React app must be running on `http://localhost:3000` before executing tests.

## Step 1: Create SmartUI Project

1. Log in to [LambdaTest SmartUI Dashboard](https://smartui.lambdatest.com)
2. Go to **Projects** page and click **New Project**
3. Select **CLI** as the platform
4. Add project name: "React Snapshot Testing" (or your preferred name)
5. Add approver's name and tags (optional)
6. Click **Continue**
7. Select **JavaScript** framework and click **Configure**

## Step 2: Get Your Project Token

After creating the project, you'll receive a **PROJECT_TOKEN**. Copy this token - you'll need it in the next step.

The token format looks like: `123456#1234abcd-****-****-****-************`

## Step 3: Set Environment Variables

### For Windows PowerShell (Current Setup):

```powershell
# Set your LambdaTest credentials (for hooks)
$env:LT_USERNAME="your_lambdatest_username"
$env:LT_ACCESS_KEY="your_lambdatest_access_key"

# Set your SmartUI Project Token (for CLI)
$env:PROJECT_TOKEN="your_project_token_here"
```

### For Windows CMD:

```cmd
set LT_USERNAME=your_lambdatest_username
set LT_ACCESS_KEY=your_lambdatest_access_key
set PROJECT_TOKEN=your_project_token_here
```

### For MacOS/Linux:

```bash
export LT_USERNAME="your_lambdatest_username"
export LT_ACCESS_KEY="your_lambdatest_access_key"
export PROJECT_TOKEN="your_project_token_here"
```

### Optional: Create `.env` file

You can also create a `.env` file in the project root (make sure to add it to `.gitignore`):

```env
LT_USERNAME=your_lambdatest_username
LT_ACCESS_KEY=your_lambdatest_access_key
PROJECT_TOKEN=your_project_token_here
APP_URL=http://localhost:3000
```

## Step 4: Configuration Files

The following configuration files have been created/updated:

- **`.smartui.json`**: SmartUI configuration with browser and viewport settings
- **`src/lambdatest.spec.js`**: Updated test file with SmartUI snapshot calls

## Step 5: Running SmartUI Tests

### Option 1: Using SmartUI CLI (Recommended)

1. **Start your React app** in one terminal:
   ```powershell
   npm start
   ```
   Wait until you see: `Local: http://localhost:3000`

2. **Run SmartUI tests** in another terminal:
   ```powershell
   npm run test:smartui
   ```

   Or directly:
   ```powershell
   npx smartui --config .smartui.json exec -- jest src/lambdatest.spec.js
   ```

### Option 2: Using Lambda Hooks (Alternative)

If you prefer using hooks, the test file is already configured. Just run:

```powershell
npm run test:lambdatest:smartui
```

## Step 6: View Results

After test execution:

1. Go to [LambdaTest SmartUI Dashboard](https://smartui.lambdatest.com)
2. Navigate to your project
3. View the build results and compare screenshots
4. Review any visual differences (mismatches) from the baseline

## Troubleshooting

### Issue: "PROJECT_TOKEN not found"
- **Solution**: Make sure you've set the `PROJECT_TOKEN` environment variable
- Verify the token is correct from your SmartUI project settings

### Issue: "Application not running"
- **Solution**: Start your React app with `npm start` before running tests
- Ensure the app is accessible at `http://localhost:3000`

### Issue: "Failed to connect to LambdaTest"
- **Solution**: Verify your `LT_USERNAME` and `LT_ACCESS_KEY` are correct
- Check your internet connection
- Verify your LambdaTest account has active minutes

### Issue: "SmartUI snapshot failed"
- **Solution**: Ensure `PROJECT_TOKEN` is set correctly
- Check that SmartUI hooks are enabled in your LambdaTest capabilities
- Verify the test is running on LambdaTest cloud (not local)

## What You Need to Do

1. ✅ **Get SmartUI Access**: Contact Saniya Gazala if you need access to SmartUI
2. ✅ **Create Project**: Create a SmartUI project in LambdaTest dashboard
3. ✅ **Get Project Token**: Copy your PROJECT_TOKEN from the project settings
4. ✅ **Set Environment Variables**: Set `PROJECT_TOKEN`, `LT_USERNAME`, and `LT_ACCESS_KEY`
5. ✅ **Run Tests**: Execute `npm run test:smartui` after starting your React app

## Additional Resources

- [SmartUI Documentation](https://www.lambdatest.com/support/docs/smartui-running-your-first-project/)
- [Visual Regression Testing Guide](https://www.lambdatest.com/support/docs/smart-visual-regression-testing/)
- [LambdaTest Support](https://www.lambdatest.com/support/)

## Notes

- The SmartUI configuration (`.smartui.json`) is set to capture screenshots in Chrome and Firefox
- Viewports configured: 1920x1080, 1366x768, and 1024x768
- The test captures 3 snapshots: Full View, Scrolled View, and Top View
- Make sure your React app is running before executing tests

