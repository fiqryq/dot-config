#!/bin/bash

NERD_FONT_FREE="󱁕 "
NERD_FONT_MEETING="󰤙"

# Get the current meeting (events happening now)
current_meeting=$(icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --dateFormat "%A" \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    eventsNow)

if [ -n "$current_meeting" ]; then
    end_time=$(echo "$current_meeting" | sed -n '3p' | awk '{print $3}')
    title=$(echo "$current_meeting" | sed -n '4p' | awk '{$1=$1;print}')

    epoc_meeting_end=$(date -j -f "%H.%M" "$end_time" +%s)
    epoc_now=$(date +%s)
    epoc_diff=$((epoc_meeting_end - epoc_now))
    minutes_left=$((epoc_diff/60))

    echo "$NERD_FONT_MEETING $title (running, $minutes_left min left)"
    exit 0
fi

# Get the next meeting
next_meeting=$(icalBuddy \
    --includeEventProps "title,datetime" \
    --propertyOrder "datetime,title" \
    --noCalendarNames \
    --dateFormat "%A" \
    --includeOnlyEventsFromNowOn \
    --limitItems 1 \
    --excludeAllDayEvents \
    --separateByDate \
    --bullet "" \
    eventsToday)

# If there is no next meeting, show the free icon and exit
if [ -z "$next_meeting" ]; then
    echo "$NERD_FONT_FREE"
    exit 0
fi

# Parse the next meeting details
time=$(echo "$next_meeting" | sed -n '3p' | awk '{print $1}')
title=$(echo "$next_meeting" | sed -n '4p' | awk '{$1=$1;print}')

# Calculate the time until the meeting
epoc_meeting=$(date -j -f "%T" "${time/./:}:00" +%s)
epoc_now=$(date +%s)
epoc_diff=$((epoc_meeting - epoc_now))
minutes_till_meeting=$((epoc_diff/60))

# Display the next meeting info
if [ "$minutes_till_meeting" -ge 60 ]; then
    hours_till_meeting=$((minutes_till_meeting/60))
    remaining_minutes=$((minutes_till_meeting%60))
    if [ "$remaining_minutes" -eq 0 ]; then
        echo "$NERD_FONT_MEETING Next: $time $title ($hours_till_meeting hour)"
    else
        echo "$NERD_FONT_MEETING Next: $time $title ($hours_till_meeting hour $remaining_minutes minutes)"
    fi
else
    echo "$NERD_FONT_MEETING Next: $time $title ($minutes_till_meeting minutes)"
fi
