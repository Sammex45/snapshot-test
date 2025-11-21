#!/usr/bin/env node

const fs = require('fs');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

console.log(' SmartUI Testing Suite - Initial Setup\n');

function question(query) {
    return new Promise(resolve => rl.question(query, resolve));
}

async function setup() {
    // Check if .env already exists
    if (fs.existsSync('.env')) {
        const overwrite = await question('.env file already exists. Overwrite? (yes/no): ');
        if (overwrite.toLowerCase() !== 'yes') {
            console.log('Setup cancelled.');
            rl.close();
            return;
        }
    }

    console.log('\n Please enter your LambdaTest credentials:');
    console.log('(You can find these at: https://accounts.lambdatest.com/security)\n');

    const username = await question('LambdaTest Username: ');
    const accessKey = await question('LambdaTest Access Key: ');

    if (!username || !accessKey) {
        console.log('\n Error: Both username and access key are required!');
        rl.close();
        return;
    }

    // Create .env file
    const envContent = `# LambdaTest Credentials
LT_USERNAME=${username}
LT_ACCESS_KEY=${accessKey}
`;

    try {
        fs.writeFileSync('.env', envContent);
        console.log('\n .env file created successfully!');
        
        // Verify .gitignore exists
        if (!fs.existsSync('.gitignore')) {
            console.log('\n  Warning: .gitignore not found. Creating one...');
            fs.writeFileSync('.gitignore', '.env\n.env.local\nnode_modules/\n');
            console.log(' .gitignore created');
        } else {
            const gitignoreContent = fs.readFileSync('.gitignore', 'utf8');
            if (!gitignoreContent.includes('.env')) {
                console.log('\n  Warning: Adding .env to .gitignore...');
                fs.appendFileSync('.gitignore', '\n.env\n.env.local\n');
                console.log(' .gitignore updated');
            }
        }

        console.log('\n Setup complete! You can now run tests using:');
        console.log('   - Windows: run-smartui-tests.bat');
        console.log('   - PowerShell/Mac/Linux: ./run-smartui-tests.ps1');
        console.log('   - Direct: npm test\n');
        
    } catch (error) {
        console.log('\n Error creating .env file:', error.message);
    }

    rl.close();
}

setup();