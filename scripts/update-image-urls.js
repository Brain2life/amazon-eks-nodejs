const fs = require('fs');
const path = require('path');

// 1. Paths
const filePath = path.join(__dirname, '../app.js');

// 2. URL replacement
const oldBaseUrl = 'https://first-demo-static-web.s3-ap-southeast-1.amazonaws.com/images';
const newBaseUrl = 'https://eks-workshop-img-bucket-339712714478.s3.us-east-1.amazonaws.com/';

// 3. Read file
let content = fs.readFileSync(filePath, 'utf8');

// 4. Replace URLs
const updatedContent = content.replaceAll(oldBaseUrl, newBaseUrl);

// 5. Save updated file
fs.writeFileSync(filePath, updatedContent, 'utf8');

console.log('app.js image URLs updated successfully.');
