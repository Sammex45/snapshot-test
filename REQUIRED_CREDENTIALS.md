# Required Credentials to Fix SmartUI Issue

## What You Need to Provide

Based on the error "Empty PROJECT_TOKEN and PROJECT_NAME", here's what you need:

### ✅ **PROJECT_TOKEN** (MOST CRITICAL - Required)

This is the **SmartUI Project Token** from your LambdaTest SmartUI dashboard.

**How to Get It:**
1. Go to [LambdaTest SmartUI Dashboard](https://smartui.lambdatest.com)
2. Log in with your LambdaTest account
3. Go to **Projects** page
4. Find your project (or create a new one)
5. Click on the project
6. Look for **Project Token** or **Token** in the project settings
7. Copy the token

**Format:** `username#projectId#projectName`
**Example:** `2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing`

**Current Value in Batch File:**
```
PROJECT_TOKEN=2827339#01K9ZPEJMFEYRM5XQ31KA2A13Q#SmartUI-Visual-Testing
```

**Action:** Verify this token is correct or provide the correct one.

---

### ✅ **LT_USERNAME** (Already Set - Verify if Correct)

Your LambdaTest username.

**Current Value in Batch File:**
```
LT_USERNAME=samuelemediong45
```

**Action:** Confirm this is your correct LambdaTest username.

---

### ✅ **LT_ACCESS_KEY** (Already Set - Verify if Correct)

Your LambdaTest access key (also called API key).

**How to Get It:**
1. Go to [LambdaTest Profile](https://accounts.lambdatest.com/profile)
2. Scroll to **Account Settings** → **Access Key**
3. Copy your access key

**Current Value in Batch File:**
```
LT_ACCESS_KEY=LT_rgM3x9H3ua7PPEJMIYNksU8R6qg1VBcpolzIiLWSARrtCeB
```

**Action:** Verify this is your current access key (they can change/expire).

---

## Priority Order

1. **PROJECT_TOKEN** ← **MOST IMPORTANT** (This is what's causing the "No snapshots processed" issue)
2. **LT_ACCESS_KEY** (Verify it's current/valid)
3. **LT_USERNAME** (Usually correct, but verify)

---

## What to Do

### Option 1: Verify Current Values
Check if the values in `run-smartui-tests.bat` are correct:
- PROJECT_TOKEN: Check in SmartUI dashboard
- LT_ACCESS_KEY: Check in LambdaTest profile
- LT_USERNAME: Should be your login username

### Option 2: Provide New Values
If any are incorrect, provide:
1. **Your PROJECT_TOKEN** (from SmartUI dashboard)
2. **Your LT_ACCESS_KEY** (from LambdaTest profile, if different)
3. **Your LT_USERNAME** (if different from `samuelemediong45`)

---

## Quick Check

Run this in CMD to see what's currently set:
```cmd
echo %PROJECT_TOKEN%
echo %LT_USERNAME%
echo %LT_ACCESS_KEY%
```

Or use the verification script:
```powershell
.\verify-setup.ps1
```

---

## Summary

**Minimum Required:** Just the **PROJECT_TOKEN** (if username and access key are correct)

**If Access Key Changed:** Provide **LT_ACCESS_KEY** as well

**If Username Different:** Provide **LT_USERNAME** as well

The most critical one is **PROJECT_TOKEN** - without it, SmartUI CLI cannot authenticate and create builds, which is why you're seeing "No snapshots processed".

