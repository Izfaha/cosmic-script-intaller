#!/usr/bin/env bash

check_not_root() {
    if [[ "$EUID" -eq 0 ]]; then
        log_error "Do NOT run this script as root."
    fi
}

check_arch_based() {
    if ! grep -qi "arch" /etc/os-release; then
        log_error "This script only supports Arch-based systems."
    fi

    log_success "Arch-based system detected."
}

check_internet() {
    log_info "Checking internet connection..."

    if ! ping -c 1 archlinux.org &>/dev/null; then
        log_error "No internet connection detected."
    fi

    log_success "Internet connection OK."
}

detect_session_type() {
    SESSION_TYPE="${XDG_SESSION_TYPE:-unknown}"
    log_info "Session type detected: $SESSION_TYPE"
}

detect_vm() {
    if systemd-detect-virt --quiet; then
        VIRT=$(systemd-detect-virt)
        log_warn "Running inside VM: $VIRT"
    else
        log_info "Running on bare metal."
    fi
}