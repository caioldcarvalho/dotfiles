{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # X11 + GDM + GNOME
  services.xserver = {
    xkb.layout = "br";
    xkb.variant = "";
    displayManager.gdm.enable = false;
    enable = false; # se não for usar X11

  };

   services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s ${pkgs.greetd.gtkgreet}/bin/gtkgreet";
        user = "caio";
      };
    };
  };
 


  console.keyMap = "br-abnt2";

  services.printing.enable = true;

  services.blueman.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User
  users.users.caio = {
    isNormalUser = true;
    description = "caio";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };

  # Programas habilitados
  programs = {
    dconf.enable = true;
    fish.enable = true;
    firefox.enable = true;
    starship.enable = true;
    hyprlock.enable = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Pacotes do sistema
  environment.systemPackages = with pkgs; [
    # Editors
    neovim
    vscode

    # CLI & Network
    git
    wget
    curl
    postman
    tree
    openssl

    # Terminal & Shell
    fish
    starship
    kitty
    neofetch
    pfetch
    cava
    cbonsai

    # DevOps / Kubernetes
    kubectl
    kind
    kubernetes-helm
    lens

    # Pessoal
    obsidian
    slack
    clickup

    # Browsers
    chromium

    libnotify

    # Fontes
    nerd-fonts.lilex
    nerd-fonts.iosevka
    nerd-fonts.geist-mono
    nerd-fonts.victor-mono
    nerd-fonts.d2coding
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.ubuntu

    # Ícones
    tela-icon-theme

    # GNOME tweaks e extensões
    gnome-tweaks
    gnomeExtensions.user-themes

    # Hyprland tools
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    waybar
    dunst
    wofi
    rofi-wayland
    hyprpaper
    hyprlock
    hyprshot
    networkmanagerapplet
    wl-clipboard
    grim
    slurp
    nautilus
    brightnessctl
    pavucontrol
    playerctl
    pulseaudio
    swww
    mpvpaper
    greetd.gtkgreet
    bibata-cursors
    orchis-theme
    # BLUTU
    blueman
    pavucontrol   # Controlador de áudio PulseAudio (útil com PipeWire)
    pulsemixer    # Versão em terminal do mixer de volume
    bluez
  ];

  environment.variables = {
    GTK_ICON_THEME = "Tela";
    GTK_THEME = "Orchis-Green-Dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.lilex
    nerd-fonts.geist-mono
    nerd-fonts.victor-mono
    nerd-fonts.iosevka
    nerd-fonts.d2coding
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.ubuntu
  ];

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Unfree
  nixpkgs.config.allowUnfree = true;

  # Versão
  system.stateVersion = "24.11";
}

