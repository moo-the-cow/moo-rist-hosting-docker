#!/bin/bash

# Docker REMOTE Version Setup
# For remote/OBS setup with encryption only

echo "Setting up Docker REMOTE Version"
echo "================================"

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

# Generate secret (42 characters, alphanumeric)
SECRET=""
for i in {1..42}; do
    rand=$((RANDOM % 62))
    SECRET="${SECRET}${chars:$rand:1}"
done

# Display generated credentials
echo ""
echo "Generated Credentials:"
echo "======================"
echo "USERNAME: $USERNAME"
echo "PASSWORD: $PASSWORD"
echo "SECRET: $SECRET"
echo "ENCRYPTION: 128"
echo ""

# Update .env file for REMOTE version
echo "Configuring .env for REMOTE version..."

# Create .env with REMOTE configuration (encryption only for OBS)
cat > .env << EOL
GLOBAL_RIST_VERSION=0.0.20

###### OBS and Relay via Internet ######

RIST_AUTHARGUMENTS="&username=${USERNAME}&password=${PASSWORD}"
RIST_AUTHARGUMENTS_FORWARDER="aes-type=128&secret=${SECRET}"
EOL

echo ""
echo "REMOTE Version Configuration Complete!"
echo "======================================"
echo "RIST Receiver Auth: username=$USERNAME, password=$PASSWORD + encryption"
echo "RIST Forwarder Auth: encryption only (for OBS compatibility)"
echo "Encryption: aes-type=128"
echo ""
echo "To start the services, run: docker-compose up -d"
echo "Credentials are stored in the .env file"
