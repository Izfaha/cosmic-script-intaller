setup_widgets() {

    log_info "Setting up widgets (EWW)..."

    mkdir -p ~/.config/eww
    cp -r ./config/eww/* ~/.config/eww/

    log_info "Starting EWW daemon..."
    eww daemon

    log_success "Widgets installed."
}