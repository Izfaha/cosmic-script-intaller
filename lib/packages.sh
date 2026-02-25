install_dependencies() {
    log_info "Installing dependencies using pacman..."

    sudo pacman -Sy --needed --noconfirm \
        git \
        base-devel \
        papirus-icon-theme \
        noto-fonts \
        noto-fonts-emoji \
        ttf-fira-code \
        wl-clipboard \
        pipewire \
        networkmanager

    log_info "Installing dependencies using paru (AUR)..."
    
    paru -Sy --needed --noconfirm \
    eww
}