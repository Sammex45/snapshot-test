#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔍 Security Verification Check\n');

const checks = {
    passed: [],
    failed: [],
    warnings: []
};

// Check 1: .gitignore exists and contains .env
function checkGitignore() {
    if (!fs.existsSync('.gitignore')) {
        checks.failed.push('.gitignore file is missing');
        return;
    }
    
    const gitignoreContent = fs.readFileSync('.gitignore', 'utf8');
    if (!gitignoreContent.includes('.env')) {
        checks.failed.push('.env is not in .gitignore');
    } else {
        checks.passed.push('.gitignore properly excludes .env');
    }
}

// Check 2: .env.example exists
function checkEnvExample() {
    if (!fs.existsSync('.env.example')) {
        checks.warnings.push('.env.example file is missing');
    } else {
        const exampleContent = fs.readFileSync('.env.example', 'utf8');
        if (exampleContent.includes('your_') || exampleContent.includes('example')) {
            checks.passed.push('.env.example uses placeholder values');
        } else {
            checks.warnings.push('.env.example may contain real credentials');
        }
    }
}

// Check 3: .env is not tracked by git
function checkEnvNotTracked() {
    const { execSync } = require('child_process');
    try {
        const trackedFiles = execSync('git ls-files', { encoding: 'utf8' });
        if (trackedFiles.includes('.env\n') || trackedFiles.includes('.env ')) {
            checks.failed.push('.env is tracked by git! Remove it immediately');
        } else {
            checks.passed.push('.env is not tracked by git');
        }
    } catch (error) {
        checks.warnings.push('Could not check git status (not a git repo?)');
    }
}

// Check 4: Scan files for potential hardcoded credentials
function scanForHardcodedCredentials() {
    const dangerousPatterns = [
        /LT_ACCESS_KEY\s*=\s*["']?LT_[a-zA-Z0-9]+/,
        /LT_USERNAME\s*=\s*["']?[a-zA-Z0-9]+["']?\s*(?!your_|example)/,
        /password\s*=\s*["'][^"']+["']/i,
        /api[_-]?key\s*=\s*["'][^"']+["']/i,
        /secret\s*=\s*["'][^"']+["']/i
    ];

    const filesToCheck = [
        'run-smartui-tests.bat',
        'run-smartui-tests.ps1',
        'package.json',
        'test-runner.js',
        'smartui-loader.js'
    ];

    let foundIssues = false;
    
    filesToCheck.forEach(file => {
        if (fs.existsSync(file)) {
            const content = fs.readFileSync(file, 'utf8');
            dangerousPatterns.forEach(pattern => {
                if (pattern.test(content) && !content.includes('.env')) {
                    checks.failed.push(`Potential hardcoded credential found in ${file}`);
                    foundIssues = true;
                }
            });
        }
    });

    if (!foundIssues) {
        checks.passed.push('No hardcoded credentials detected in scripts');
    }
}

// Check 5: README exists and mentions .env setup
function checkReadme() {
    if (!fs.existsSync('README.md')) {
        checks.warnings.push('README.md is missing');
    } else {
        const readmeContent = fs.readFileSync('README.md', 'utf8');
        if (readmeContent.includes('.env') && readmeContent.includes('setup')) {
            checks.passed.push('README documents .env setup');
        } else {
            checks.warnings.push('README should document .env setup process');
        }
    }
}

// Run all checks
console.log('Running security checks...\n');
checkGitignore();
checkEnvExample();
checkEnvNotTracked();
scanForHardcodedCredentials();
checkReadme();

// Display results
console.log(' PASSED CHECKS:');
checks.passed.forEach(check => console.log(`   ✓ ${check}`));

if (checks.warnings.length > 0) {
    console.log('\n  WARNINGS:');
    checks.warnings.forEach(warning => console.log(`   ! ${warning}`));
}

if (checks.failed.length > 0) {
    console.log('\n FAILED CHECKS:');
    checks.failed.forEach(failure => console.log(`   ✗ ${failure}`));
    console.log('\n DO NOT PUSH TO REPOSITORY UNTIL ALL ISSUES ARE RESOLVED!\n');
    process.exit(1);
} else {
    console.log('\n All security checks passed! Safe to push to repository.\n');
    process.exit(0);
}