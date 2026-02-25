#!/usr/bin/env bash

set -Eeuo pipefail

VERSION="1.0.0"
LOG_FILE="install.log"
DRY_RUN=false
START_TIME=$(date +%s)

# ===============================
# Trap Error
# ===============================
trap 'echo -e "\n[ERROR] Failed at line $LINENO. Check $LOG_FILE"; exit 1' ERR

# ===============================
# Load Libraries
# ===============================
source ./lib/log.sh
source ./lib/detect.sh
source ./lib/aur.sh
source ./lib/packages.sh
source ./lib/cosmic.sh
source ./lib/theme.sh
source ./lib/widgets.sh

# ===============================
# Parse Arguments
# ===============================
for arg in "$@"; do
    case $arg in
        --dry-run)
            DRY_RUN=true
            ;;
        --version)
            echo "COSMIC Tealinux Rice v$VERSION"
            exit 0
            ;;
        *)
            ;;
    esac
done

# ===============================
# Helper Step Counter
# ===============================
STEP=1
step() {
    log_step "Step $STEP: $1"
    ((STEP++))
}

# ===============================
# Main Installer
# ===============================
main() {

    log_info "======================================="
    log_info " COSMIC Tealinux Rice Installer v$VERSION"
    log_info " Log file: $LOG_FILE"
    log_info "======================================="

    if [[ "$DRY_RUN" = true ]]; then
        log_warn "Running in DRY RUN mode (no changes will be made)"
    fi

    step "System Checks"
    check_not_root
    check_arch_based
    check_internet
    detect_session_type
    detect_vm

    step "Installing Base Dependencies"
    [[ "$DRY_RUN" = false ]] && install_dependencies

    step "Installing COSMIC Desktop"
    [[ "$DRY_RUN" = false ]] && install_cosmic_stack

    step "Enabling Display Manager"
    [[ "$DRY_RUN" = false ]] && enable_display_manager

    step "Setting Default Session"
    [[ "$DRY_RUN" = false ]] && set_default_session

    step "Applying Theme & Icons"
    [[ "$DRY_RUN" = false ]] && apply_theme

    step "Setting Up Widgets"
    [[ "$DRY_RUN" = false ]] && setup_widgets

    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))

    log_success "Installation completed in ${DURATION}s"
    log_info "Please reboot and select COSMIC session."
}

# ===============================
# Run
# ===============================
main "$@" 2>&1 | tee "$LOG_FILE"