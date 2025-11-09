#!/bin/bash

# Get memory usage on macOS
mem_free=$(memory_pressure | grep 'System-wide memory free percentage:' | awk '{print $5}' | sed 's/%//')
mem_used=$((100 - mem_free))
echo "${mem_used}%"
