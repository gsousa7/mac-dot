#!/bin/bash
# ~/.config/tmux/scripts/weather.sh
###NEW### Shebang movido para linha 1 (era linha 2)

# Cache file and TTL (30 minutes)
CACHE_FILE="/tmp/tmux-weather-cache"
CACHE_TTL=1800

# Check if cache is valid
###NEW### stat -f (macOS) primeiro, -c (Linux) como fallback
if [ -f "$CACHE_FILE" ]; then
    cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)))
    if [ "$cache_age" -lt "$CACHE_TTL" ]; then
        cat "$CACHE_FILE"
        exit 0
    fi
fi

# Fetch weather (change location as needed)
# Format: temperature + condition icon
weather=$(curl -s "wttr.in/Lisbon?format=%t+%c" 2>/dev/null | tr -d '+')

if [ -n "$weather" ]; then
    echo "$weather" > "$CACHE_FILE"
    echo "$weather"
fi
