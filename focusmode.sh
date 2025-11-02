#!/bin/bash
# =====================================================
# focusmode.sh — Block distracting websites temporarily
# Author: Prakash Choudhary (@TheLinuxPoint)
# Version: 2.0 — Now with custom add/remove support!
# =====================================================

HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/tmp/hosts_focus_backup"
CUSTOM_FILE="$HOME/.focus_blocklist"

# Default blocklist
DEFAULT_BLOCK_LIST=(
"www.youtube.com"
"youtube.com"
"www.instagram.com"
"instagram.com"
"www.reddit.com"
"reddit.com"
"twitter.com"
"x.com"
"www.netflix.com"
"www.primevideo.com"
"chat.openai.com"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Require sudo for /etc/hosts modification
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}⚠️  Please run this script with sudo.${RESET}"
  exit 1
fi

# Initialize custom list if missing
if [ ! -f "$CUSTOM_FILE" ]; then
  printf "%s\n" "${DEFAULT_BLOCK_LIST[@]}" > "$CUSTOM_FILE"
fi

read_blocklist() {
  mapfile -t BLOCK_LIST < "$CUSTOM_FILE"
}

save_blocklist() {
  printf "%s\n" "${BLOCK_LIST[@]}" > "$CUSTOM_FILE"
}

enable_focus() {
  echo -e "${YELLOW}Enabling Focus Mode...${RESET}"
  read_blocklist

  cp "$HOSTS_FILE" "$BACKUP_FILE"

  for site in "${BLOCK_LIST[@]}"; do
    if ! grep -q "$site" "$HOSTS_FILE"; then
      echo "127.0.0.1 $site" >> "$HOSTS_FILE"
    fi
  done

  echo -e "${GREEN}✅ Focus Mode enabled!${RESET}"
}

disable_focus() {
  echo -e "${YELLOW}Disabling Focus Mode...${RESET}"
  if [ -f "$BACKUP_FILE" ]; then
    cp "$BACKUP_FILE" "$HOSTS_FILE"
    rm "$BACKUP_FILE"
    echo -e "${GREEN}✅ Focus Mode disabled!${RESET}"
  else
    echo -e "${RED}⚠️  No backup found!${RESET}"
  fi
}

add_site() {
  read -p "Enter site to block (e.g. example.com): " site
  if [[ -n "$site" ]]; then
    BLOCK_LIST+=("$site")
    save_blocklist
    echo -e "${GREEN}✅ Added '$site' to block list.${RESET}"
  fi
}

remove_site() {
  read -p "Enter site to remove: " site
  read_blocklist
  NEW_LIST=()
  found=false
  for s in "${BLOCK_LIST[@]}"; do
    if [[ "$s" != "$site" ]]; then
      NEW_LIST+=("$s")
    else
      found=true
    fi
  done

  if [ "$found" = true ]; then
    BLOCK_LIST=("${NEW_LIST[@]}")
    save_blocklist
    echo -e "${GREEN}✅ Removed '$site' from block list.${RESET}"
  else
    echo -e "${RED}❌ '$site' not found.${RESET}"
  fi
}

view_sites() {
  read_blocklist
  echo -e "\n${YELLOW}📋 Current Blocked Sites:${RESET}"
  for site in "${BLOCK_LIST[@]}"; do
    echo "• $site"
  done
}

show_menu() {
  clear
  echo "╔══════════════════════════════════════╗"
  echo "║        🧠 Focus Mode Tool v2.0       ║"
  echo "╚══════════════════════════════════════╝"
  echo
  echo "1) Enable Focus Mode"
  echo "2) Disable Focus Mode"
  echo "3) View Block List"
  echo "4) Add Custom Site"
  echo "5) Remove Custom Site"
  echo "6) Exit"
  echo
  read -p "Select an option (1-6): " choice

  case $choice in
    1) enable_focus ;;
    2) disable_focus ;;
    3) view_sites ;;
    4) add_site ;;
    5) remove_site ;;
    6) exit 0 ;;
    *) echo -e "${RED}Invalid option${RESET}" ;;
  esac
}

while true; do
  show_menu
  echo
  read -p "Press Enter to continue..." _
done
