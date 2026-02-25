install_dependencies() {
    log_info "Installing dependencies..."

    sudo pacman -S --needed --noconfirm \
        git \
        base-devel \
        papirus-icon-theme \
        noto-fonts \
        noto-fonts-emoji \
        ttf-fira-code \
        eww \
        wl-clipboard \
        pipewire \
        networkmanager
}