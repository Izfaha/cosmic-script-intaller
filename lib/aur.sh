#!/usr/bin/env bash

AUR_HELPER=""

detect_aur_helper() {

    if command -v paru &>/dev/null; then
        AUR_HELPER="paru"
        log_success "Detected AUR helper: paru"
        return
    fi

    if command -v yay &>/dev/null; then
        AUR_HELPER="yay"
        log_success "Detected AUR helper: yay"
        return
    fi

    log_warn "No AUR helper detected."
    install_yay
    AUR_HELPER="yay"
}

install_yay() {

    log_info "Installing yay as fallback AUR helper..."

    sudo pacman -S --needed --noconfirm git base-devel

    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null

    log_success "yay installed successfully."
}

install_aur_package() {

    PKG="$1"

    if pacman -Qi "$PKG" &>/dev/null; then
        log_success "$PKG already installed."
        return
    fi

    if [[ -z "$AUR_HELPER" ]]; then
        detect_aur_helper
    fi

    log_info "Installing AUR package: $PKG using $AUR_HELPER"

    case "$AUR_HELPER" in
        paru)
            paru -S --needed --noconfirm "$PKG"
            ;;
        yay)
            yay -S --needed --noconfirm "$PKG"
            ;;
        *)
            log_error "No valid AUR helper found."
            ;;
    esac

    log_success "$PKG installation completed."
}