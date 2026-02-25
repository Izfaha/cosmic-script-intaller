apply_theme() {

    log_info "Applying icon theme Papirus..."

    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

    log_info "Setting GTK theme..."

    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

    log_info "Enabling transparency..."

    mkdir -p ~/.config/cosmic
    cp -r ./config/cosmic/* ~/.config/cosmic/

    log_success "Theme applied."
}