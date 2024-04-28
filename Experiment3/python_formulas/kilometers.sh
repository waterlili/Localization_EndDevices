#!/bin/bash

# Prompt the user to enter a value in meters
read -p "Enter a value in meters: " meters

# Use bc to perform the conversion to kilometers
kilometers=$(echo "scale=9; $meters / 1000" | bc)

echo "The value in kilometers: $kilometers km"

