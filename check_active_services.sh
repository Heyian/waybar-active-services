#!/bin/bash

# List of services to check
# Modify this list with the name of your services
services=(
    "resticprofile-backup@profile-externalhdd"
    "resticprofile-backup@profile-proxmox"
    "rsyncBak"
    # Add more services as needed
)

# Function to check if a service is active
check_service() {
    systemctl is-active --quiet "$1"
    return $?
}

# Count active services and generate tooltip
get_active_services() {
    local count=0
    local tooltip=""
    for service in "${services[@]}"; do
        if check_service "$service"; then
            ((count++))
            [ -n "$tooltip" ] && tooltip+=" "
            tooltip+="$service"
        fi
    done
    echo "$count|$tooltip"
}

# Function to display detailed service status
# used when you click on the waybar icon
display_service_details() {
    echo -e "\e[1mService Status:\e[0m"
    for service in "${services[@]}"; do
        status=$(systemctl is-active "$service")
        if [ "$status" = "active" ]; then
            echo -e "  $service: \e[32m$status\e[0m"
        else
            echo -e "  $service: \e[31m$status\e[0m"
        fi
    done
}

# Generate Waybar output
generate_waybar_output() {
    local result=$(get_active_services)
    local active_count=$(echo "$result" | cut -d'|' -f1)
    local tooltip=$(echo "$result" | cut -d'|' -f2)
    
    if [ $active_count -gt 0 ]; then
        tooltip=$(printf 'Active Services: %s' "$tooltip")
        tooltip="${tooltip//\"/\\\"}"
        echo "{\"text\": \"  $active_count\", \"alt\": \"Active\", \"class\": \"active\", \"tooltip\": \"$tooltip\"}"
    else
        echo ""  # Empty output to hide the module
    fi
}

# Main execution
if [[ "$1" == "--details" ]]; then
    display_service_details
else
    generate_waybar_output
fi

