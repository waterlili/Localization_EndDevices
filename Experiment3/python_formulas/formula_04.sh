#!/bin/bash

# Prompt the user to enter a timestamp
read -p "Enter a timestamp (e.g., 2023-10-31T15:55:03.315837205Z): " timestamp

# Extract the timestamp in the format YYYY-MM-DDTHH:MM:SS.sssssssssZ
timestamp_format="${timestamp%Z}"

# Calculate the seconds since epoch
seconds_since_epoch=$(date -d "$timestamp_format" +"%s.%N")

echo "Time in seconds since the epoch: $seconds_since_epoch"

