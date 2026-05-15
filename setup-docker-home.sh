#!/bin/bash

# Docker HOME Version Setup
# For home network setup with username/password authentication only

echo "Setting up Docker HOME Version"
echo "=============================="

# Generate random credentials
echo "Generating random credentials..."

# Generate username with "moo-" prefix (max 22 characters total, so 18 random chars)
chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
USERNAME="moo-"
for i in {1..18}; do
    rand=$((RANDOM % 62))
    USERNAME="${USERNAME}${chars:$rand:1}"
done

# Generate password (30 characters, alphanumeric)
PASSWORD=""
for i in {1..30}; do
    rand=$((RANDOM % 62))
    PASSWORD="${PASSWORD}${chars:$rand:1}"
done

# Display generated credentials
echo ""
echo "Generated Credentials:"
echo "======================"
echo "USERNAME: $USERNAME"
echo "PASSWORD: $PASSWORD"
echo ""

# Update .env file for HOME version
echo "Configuring .env for HOME version..."

# Create .env with HOME configuration only (username/password, no encryption)
cat > .env << EOL
GLOBAL_RIST_VERSION=0.0.20

##### Home network setup #######

RIST_AUTHARGUMENTS="&username=${USERNAME}&password=${PASSWORD}"
RIST_AUTHARGUMENTS_FORWARDER=""
EOL

echo ""
echo "HOME Version Configuration Complete!"
echo "===================================="
echo "RIST Receiver Auth: username=$USERNAME, password=$PASSWORD"
echo "RIST Forwarder Auth: None (empty)"
echo "No encryption - for home network use only"
echo ""
echo "To start the services, run: docker-compose up -d"
echo "Credentials are stored in the .env file"
