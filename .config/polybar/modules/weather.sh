#!/usr/bin/env bash
    
weather_data=$(curl -Ss 'https://wttr.in?0&T&Q' | cut -c 16- | head -2)
weather_icon="☀"
output="$weather_icon $weather_data"

echo "$output"