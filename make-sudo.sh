#!/bin/bash

# Check for root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Check parameter
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USER_TO_ADD="$1"

# Check if user exists
if ! id "$USER_TO_ADD" >/dev/null 2>&1; then
    echo "Error: User '$USER_TO_ADD' does not exist."
    exit 1
fi

# Add user to sudo group
usermod -aG sudo "$USER_TO_ADD"

echo "User '$USER_TO_ADD' has been added to the 'sudo' group."