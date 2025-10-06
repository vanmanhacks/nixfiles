{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git

    alacritty

    zsh
    starship
    eza
    bat
    ripgrep
    anew
    btop
    zoxide
    fzf
    du-dust
    ouch
    fd
    nushell

    neovim
    xclip

    tree
    fastfetch
    flameshot

    yt-dlp

    brave
    ungoogled-chromium
    tor-browser
    mullvad-browser
    calibre
    obsidian
    pandoc

    keepassxc
    veracrypt
    borgbackup
    vorta

    privoxy
    mullvad
    mullvad-vpn
    qbittorrent-enhanced

    localsend
    syncthing
    flatpak

    ansible
    #vagrant

    rustup
    python314
    go
    typescript

    kdePackages.filelight
    kdePackages.plasma-workspace-wallpapers
    kdePackages.partitionmanager
    kdePackages.isoimagewriter
    kdePackages.sddm-kcm
    kdePackages.plasma-browser-integration
    catppuccin-sddm
    where-is-my-sddm-theme
    nordic

    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
    kdePackages.qtwayland

    spotify
    reaper
    libreoffice-qt-fresh
    vlc

    bottles
    virt-manager

    lynis
    clamav
    aide
    kernel-hardening-checker

    sbctl
    fwupd
    e2fsprogs
    usbguard

    monero-cli
    monero-gui
    p2pool
    xmrig

    freeplane
    goofcord
    neovide

    mat2

    skim
    thumbs
    tmuxifier

    halloy
    evil-helix
  ];

}
