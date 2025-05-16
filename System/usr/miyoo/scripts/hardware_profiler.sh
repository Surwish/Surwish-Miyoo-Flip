#!/bin/bash

# Define the log directory and log rotation size
LOG_DIR="/mnt/sdcard/miyoo355/profiler_logs"
LOG_FILE="$LOG_DIR/profiler_log"
LOG_MAX_SIZE=$((20 * 1024 * 1024)) # 20 MB

# Create the log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to rotate logs
rotate_logs() {
    if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE") -ge $LOG_MAX_SIZE ]; then
        mv "$LOG_FILE" "$LOG_FILE.$(date +%s)"
    fi
}

# Function to log metrics
log_metrics() {
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # CPU Metrics
    CPU_LOAD=$(cat /proc/loadavg | awk '{print $1}')

    CPU_FREQUENCIES=""
    for cpu_freq_file in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq; do
        core=$(basename $(dirname $cpu_freq_file))
        freq=$(cat $cpu_freq_file 2>/dev/null || echo "N/A")
        freq_mhz=$(awk "BEGIN {printf \"%.2f\", $freq / 1000}")
        CPU_FREQUENCIES+="$core Frequency: $freq_mhz MHz\n"
    done

    # RAM Metrics
    MEM_INFO=$(cat /proc/meminfo)
    MEM_TOTAL=$(echo "$MEM_INFO" | grep "MemTotal:" | awk '{print $2}')
    MEM_FREE=$(echo "$MEM_INFO" | grep "MemFree:" | awk '{print $2}')
    MEM_AVAILABLE=$(echo "$MEM_INFO" | grep "MemAvailable:" | awk '{print $2}')
    MEM_TOTAL_MB=$(awk "BEGIN {printf \"%.2f\", $MEM_TOTAL / 1024}")
    MEM_FREE_MB=$(awk "BEGIN {printf \"%.2f\", $MEM_FREE / 1024}")
    MEM_AVAILABLE_MB=$(awk "BEGIN {printf \"%.2f\", $MEM_AVAILABLE / 1024}")

    # GPU Metrics
    GPU_FREQ=$(cat /sys/devices/platform/fde60000.gpu/devfreq/fde60000.gpu/cur_freq 2>/dev/null || echo "N/A")
    GPU_LOAD=$(cat /sys/devices/platform/fde60000.gpu/devfreq/fde60000.gpu/load 2>/dev/null || echo "N/A")
    GPU_FREQ_MHZ=$(awk "BEGIN {printf \"%.2f\", $GPU_FREQ / 1000000}")

    # Power Metrics
    SOC_RUNTIME_STATUS=$(cat /sys/devices/system/cpu/power/runtime_status 2>/dev/null || echo "N/A")
    SOC_RUNTIME_USAGE=$(cat /sys/devices/system/cpu/power/runtime_usage 2>/dev/null || echo "N/A")
    BATTERY_VOLTAGE=$(cat /sys/class/power_supply/battery/voltage_now 2>/dev/null || echo "N/A")
    BATTERY_VOLTAGE_V=$(awk "BEGIN {printf \"%.2f\", $BATTERY_VOLTAGE / 1000000}")
    BATTERY_CURRENT=$(cat /sys/class/power_supply/battery/current_now 2>/dev/null || echo "N/A")
    BATTERY_CURRENT_A=$(awk "BEGIN {printf \"%.6f\", $BATTERY_CURRENT / 1000000}")
    BATTERY_POWER=$(awk "BEGIN {printf \"%.2f\", $BATTERY_VOLTAGE_V * $BATTERY_CURRENT_A}")
    BATTERY_STATUS=$(cat /sys/class/power_supply/battery/status 2>/dev/null || echo "N/A")
    BATTERY_HEALTH=$(cat /sys/class/power_supply/battery/health 2>/dev/null || echo "N/A")

    # Log the data
    {
        echo "--- Timestamp: $TIMESTAMP ---"
        echo "CPU Load: $CPU_LOAD"
        echo -e "$CPU_FREQUENCIES"
        echo "RAM Total: $MEM_TOTAL_MB MB"
        echo "RAM Free: $MEM_FREE_MB MB"
        echo "RAM Available: $MEM_AVAILABLE_MB MB"
        echo "GPU Frequency: $GPU_FREQ_MHZ MHz"
        echo "GPU Load: $GPU_LOAD"
        echo "SOC Runtime Status: $SOC_RUNTIME_STATUS"
        echo "SOC Runtime Usage: $SOC_RUNTIME_USAGE"
        echo "Battery Voltage: $BATTERY_VOLTAGE_V V"
        echo "Battery Current: $BATTERY_CURRENT_A A"
        echo "Battery Power Usage: $BATTERY_POWER W"
        echo "Battery Status: $BATTERY_STATUS"
        echo "Battery Health: $BATTERY_HEALTH"
        echo "---------------------------------------------------"
    } >> "$LOG_FILE"
}

# Run the profiler indefinitely
while true; do
    rotate_logs
    log_metrics
    sleep 1

done &
