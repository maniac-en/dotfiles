#!/usr/bin/env bash

TOKEN="$GITHUB_NOTIFICATION_TOKEN"

notifications=$(curl -H "Authorization: token $TOKEN" -fs 'https://api.github.com/notifications' | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo " $notifications "
else
    echo ""
fi
