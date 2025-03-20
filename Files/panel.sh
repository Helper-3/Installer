#!/bin/bash

# Display the banner
cat << "EOF"
=================================================================
|             By @id.apple.com or Network.bypass                |
=================================================================
           |  SkyPort Auto-Installer @ 2025 Update  |
          ===========================================
EOF

echo "🔑 Setting up NodeSource repository for Node.js..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

echo "🚀 Updating system packages..."
sudo apt update

echo "📦 Installing Node.js and Git..."
sudo apt install -y nodejs git

echo "🌐 Cloning the SkyPort repository..."
git clone https://github.com/achul123/panel5

if [ $? -ne 0 ]; then
  echo "❌ Failed to clone the repository."
  exit 1
fi

echo "📂 Changing directory to SkyPort..."
cd panel5 || { echo "❌ Failed to change directory to SkyPort."; exit 1; }

echo "📦 Installing Node dependencies..."
npm install

echo "🌱 Seeding the database..."
npm run seed

echo "👤 Creating a new user..."
npm run createUser 

echo "🚀 Starting SkyPort..."
node .
