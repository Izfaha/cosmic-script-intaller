#!/usr/bin/env bash

install_cosmic_stack() {

    log_info "Installing COSMIC stack..."

    COSMIC_PACKAGES=(
        cosmic-session
        cosmic-panel
        cosmic-launcher
        cosmic-settings
        cosmic-comp
    )

    for pkg in "${COSMIC_PACKAGES[@]}"; do
        install_aur_package "$pkg"
    done
}

enable_display_manager() {

    log_info "Enabling display manager..."

    if systemctl is-enabled gdm &>/dev/null; then
        log_success "GDM already enabled."
        return
    fi

    sudo pacman -S --needed --noconfirm gdm
    sudo systemctl enable gdm

    log_success "GDM enabled."
}

set_default_session() {

    log_info "Setting COSMIC as default session..."

    mkdir -p ~/.config/environment.d

    echo "XDG_CURRENT_DESKTOP=COSMIC" > ~/.config/environment.d/cosmic.conf

    log_success "Default session configured."
}