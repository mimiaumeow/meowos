# MeowOS
# by mia | mimiaumeow.github.io

# TO-DO:
# - BTRFS
# - Full Disk Encryption
# - Amnesia
# - systemd-boot Configuration
# - Fix Plymouth Theme
# - Change Login Manager Theme
# - Automize Post Installation

# -- REGULAR INSTALL -- # (nixos-minimal.iso)
# sudo -i
# loadkeys de
# -- PREPARE DISK -- #
# parted /dev/sda -- mklabel gpt
# parted /dev/sda -- mkpart primary 512MB -8GB
# parted /dev/sda -- mkpart primary linux-swap -8GB 100%
# parted /dev/sda -- mkpart ESP fat32 1MB 512MB
# parted /dev/sda -- set 3 esp on
# mkfs.ext4 -L nixos /dev/sda1
# mkswap -L swap /dev/sda2
# mkfs.fat -F 32 -n boot /dev/sda3
# -- INSTALLATION -- #
# mount /dev/disk/by-label/nixos /mnt
# mkdir -p /mnt/boot
# mount /dev/disk/by-label/boot /mnt/boot
# swapon /dev/sda2
# -- CONFIGURATION -- #
# »»» /mnt/etc/nixos/configuration.nix (or run: nixos-generate-config --root /mnt)
# nixos-install
# reboot
# -- POST -- #
# KeePassDX:
# - Enable Dark Mode
# Librewolf:
# - Settings
# - Bookmarks
# - Toolbar
# - Theme
# - Extensions
# - Configure Extensions
# - NextDNS
# Krita:
# - Set Keybinds
# Scribus:
# - Download Theme
# Focuswriter:
# - Install Theme
# - Edit Theme (Change Wallpaper)
# - Change Settings
# Libresprite:
# - Download Theme
# - Set Keybinds
# Vencord:
# - Install
# - Copy Config

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-23.05.tar.gz}/nixos")
  ];

    # --- MIA --- #

  home-manager.users.mia = {
    # - PACKAGES - #
    home.packages = [
      pkgs.cmatrix
      pkgs.flatpak
      pkgs.librewolf
      pkgs.keepassxc
      pkgs.alacritty
      pkgs.gnome.nautilus
      pkgs.discord
      pkgs.steam
      pkgs.lutris
      pkgs.heroic
      pkgs.krita
      pkgs.libresprite
      pkgs.inkscape
      pkgs.scribus
      pkgs.blender
      pkgs.gnome.gnome-calculator
      pkgs.libreoffice
      pkgs.focuswriter
      pkgs.virt-manager
      pkgs.godot
    ];

    # - CONFIGS - #
    #   FOCUSWRITER
    home.file.".config/manual/focuswriter/catppuccin".text = ''
      [General]
      LoadColor=#d8aae2
      Name=catppuccin

      [Background]
      Color=#666666
      ImageFile=2-a16c5d75f9fa6fda5a885768f6eedbd840e74211.png
      Type=5

      [Foreground]
      Color=#ffffff
      Margin=50
      Opacity=90
      Padding=15
      Position=1
      Rounding=10
      RoundingDisabled=0
      Width=750

      [ForegroundBlur]
      Enabled=false
      Radius=32

      [ForegroundShadow]
      Color=#000000
      Enabled=true
      Offset=5
      Radius=10

      [Spacings]
      IndentFirstLine=true
      LineSpacing=100
      ParagraphAbove=0
      ParagraphBelow=5
      TabWidth=50

      [Text]
      Color=#000000
      Font="TT2020 Style E,12,-1,5,50,0,0,0,0,0"
      Misspelled=#ff0000
    '';
    #   ZSH
    programs.zsh = {
      enable = true;
      shellAliases = {
        la = "ls -lAF";
        g = "git clone";
        gc = "git commit";
        ga = "git add";
        gi = "git init";
        gp = "git push";
        gf = "git fetch";
        matrix = "cmatrix -absC white";
        x = "chmod +x";
        mnt = "sudo mount";
        umnt = "sudo umount";
        unmount = "sudo umount";
        ld = "lsblk";
        k = "killall -9";
        edit = "sudo vim /etc/nixos/configuration.nix";
        update = "sudo nixos-rebuild boot";
        upgrade = "sudo nixos-rebuild switch";
        gen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        rmgen = "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system";
        purge = "nix-collect-garbage -d";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "avit";
      };
      enableAutosuggestions = true;
      initExtra = "clear";# && date + "%A%n%d.%m.%Y%n%u %H:%M";
    };
    #   ALACRITTY
    home.file.".config/alacritty/alacritty.yml".text = ''
      window:
        opacity: 0.8
      cursor:
        style: Underline
      font:
        normal:
          family: Monocraft
          style: Regular
        bold:
          family: Monocraft
          style: Regular
        italic:
          family: Monocraft
          style: Regular
        bold_italic:
          family: Monocraft
          style: Regular
        size: 11.0
      colors:
        primary:
          background: "#1E1E2E" # base
          foreground: "#CDD6F4" # text
          dim_foreground: "#CDD6F4" # text
          bright_foreground: "#CDD6F4" # text
        cursor:
          text: "#1E1E2E" # base
          cursor: "#F5E0DC" # rosewater
        vi_mode_cursor:
          text: "#1E1E2E" # base
          cursor: "#B4BEFE" # lavender
        search:
          matches:
            foreground: "#1E1E2E" # base
            background: "#A6ADC8" # subtext0
          focused_match:
            foreground: "#1E1E2E" # base
            background: "#A6E3A1" # green
          footer_bar:
            foreground: "#1E1E2E" # base
            background: "#A6ADC8" # subtext0
          hints:
            start:
              foreground: "#1E1E2E" # base
              background: "#F9E2AF" # yellow
            end:
              foreground: "#1E1E2E" # base
              background: "#A6ADC8" # subtext0
          selection:
            text: "#1E1E2E" # base
            background: "#F5E0DC" # rosewater
          normal:
            black: "#45475A"
            red: "#F38BA8"
            green: "#A6E3A1"
            yellow: "#F9E2AF"
            blue: "#89B4FA"
            magenta: "#F5C2E7"
            cyan: "#94E2F5"
            white: "#BAC2DE"
          bright:
            black: "#585B70"
            red: "#F38BA8"
            green: "#A6E3A1"
            yellow: "#F9E2AF"
            blue: "#89B4FA"
            magenta: "#F5C2E7"
            cyan: "#94E2D5"
            white: "#A6ADC8"
          dim:
            black: "#45475A"
            red: "#F38BA8"
            green: "A6E3A1"
            yellow: "#F9E2AF"
            blue: "#89B4FA"
            magenta: "#F5C2E7"
            cyan: "#94E2D5"
            white: "#BAC2DE"
          indexed_colors:
            - { index: 16, color: "#FAB387" }
            - { index: 17, color: "#F5E0DC" }
    '';
    #   VIM
    programs.vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ catppuccin-vim vim-polyglot auto-pairs nerdtree ];
      extraConfig = ''
        set nocompatible
        filetype off
        filetype plugin indent on
        let g:AutoPairsShortcutToggle = '<C-P>'
        let NERDTreeShowBookmarks = 1
        let NERDTreeShowHidden = 1
        let NERDTreeShowLineNumbers = 1
        let NERDTreeShowLineNumbers = 0
        let NERDTreeMinimalMenu = 1
        let NERDTreeWinPos = "left"
        let NERDTreeWinSize = 31
        set nu
        syntax on
        set incsearch
        set hlsearch
        set splitbelow
        set mouse=a
        set tabstop=4
        set shiftwidth=4
        colorscheme catppuccin_mocha
        hi Normal ctermbg=NONE guibg=NONE
      '';
    };
    #   DESKTOP
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          tweaks = [ "rimless" "black" ];
          variant = "mocha";
        };
      };
      cursorTheme = {
        name = "Catppuccin-Mocha-Dark-Cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "mauve";
          flavor = "mocha";
        };
      };
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      # FOR VIRT-MANAGER:
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu///system"];
      };
    };
    home.sessionVariables.GTK_THEME = "Catppuccin-Mocha-Compact-Mauve-Dark";
    home.file.".config/hypr/hyprland.conf".text = ''
    #     WALLPAPER & THEME
      exec-once = swaybg -i ~/.wallpaper.png
      exec-once = GTK_THEME="Catppuccin-Mocha-Compact-Mauve-Dark"
      env = GTK_THEME,Catppuccin-Mocha-Compact-Mauve-Dark
    #     KEYBINDS
      $mod = SUPER
      bind = $mod, Q, killactive
      bind = $mod, T, exec, alacritty
      bind = $mod, B, exec, librewolf
      bind = $mod, P, exec, keepassxc
      bind = $mod, F, exec, nautilus
      bind = $mod, C, exec, vencord
      bind = $mod, G, exec, steam
      bind = $mod, K, exec, krita
      bind = $mod, L, exec, libresprite
      bind = $mod, I, exec, inkscape
      bind = $mod, Z, exec, scribus
      bind = $mod, M, exec, blender
      bind = $mod, C, exec, gnome-calculator
      bind = $mod, O, exec, libreoffice
      bind = $mod, N, exec, focuswriter
      bind = $mod, V, exec, virt-manager
      bind = $mod, U, exec, godot
      bind = $mod, SPACE, togglefloating
      bind = SUPERSHIFT, F, fullscreen
      bind = ,PRINT, exec, grim -g "$(slurp)"
      bind = $mod, R, exec, wofi --show drun
      bind = $mod, E, exec, wofi-emoji
      bind = $mod, ALT P, pseudo
      bind = $mod, ALT J, togglesplit
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d
      bind = $mod, A, movefocus, l
      bind = $mod, D, movefocus, r
      bind = $mod, W, movefocus, u
      bind = $mod, S, movefocus, d
      bind = SUPERSHIFT, left, movewindow, l
      bind = SUPERSHIFT, right, movewindow, r
      bind = SUPERSHIFT, up, movewindow, u
      bind = SUPERSHIFT, down, movewindow, d
      bind = SUPERSHIFT, A, movewindow, l
      bind = SUPERSHIFT, D, movewindow, r
      bind = SUPERSHIFT, W, movewindow, u
      bind = SUPERSHIFT, S, movewindow, d
      bind = SUPERALT, A, resizeactive, -30 0
      bind = SUPERALT, D, resizeactive, 30 0
      bind = SUPERALT, W, resizeactive, 0 -30
      bind = SUPERALT, S, resizeactive, 0 30
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9
      bind = $mod, 0, workspace, 10
      bind = SUPERSHIFT, 1, movetoworkspace, 1
      bind = SUPERSHIFT, 2, movetoworkspace, 2
      bind = SUPERSHIFT, 3, movetoworkspace, 3
      bind = SUPERSHIFT, 4, movetoworkspace, 4
      bind = SUPERSHIFT, 5, movetoworkspace, 5
      bind = SUPERSHIFT, 6, movetoworkspace, 6
      bind = SUPERSHIFT, 7, movetoworkspace, 7
      bind = SUPERSHIFT, 8, movetoworkspace, 8
      bind = SUPERSHIFT, 9, movetoworkspace, 9
      bind = SUPERSHIFT, 0, movetoworkspace, 10
    #     WM
      input {
        kb_layout = de
        follow_mouse = 1
        sensitivity = 0
        force_no_accel = 1
      }
      general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgba(cba6f7ff) rgba(f5c2e7ff) 45deg
        col.inactive_border = rgba(1e1e2eff)
        layout = dwindle
      }
      decoration {
        rounding = 5
        blur = yes
        blur_size = 5
        blur_passes = 1
        blur_new_optimizations = on
        drop_shadow = yes
        shadow_range = 5
        shadow_render_power = 5
        col.shadow = rgba(11111bee)
        active_opacity = 1.0
        inactive_opacity = 1.0
      }
      animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.5
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }
      dwindle {
        pseudotile = yes
        preserve_split = yes
      }
      gestures {
        workspace_swipe = off
      }
      windowrule = opacity 50, alacritty
      exec-once=hyprctl setcursor Catppuccin-Mocha-Dark-Cursors 24
    '';

    # - OTHER FILES - #
    #

    home.stateVersion = "23.05";
  };
    # - BACK - #
  users.users.mia = {
    initialPassword = "7575";
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "audio" "video" "seat" "libvirtd" ];
  };

    # --- ROOT --- #

    # - PACKAGES - #
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    grim
    slurp
    swaybg
    wl-clipboard
    wdisplays
    xwayland
    wofi
    wofi-emoji
    pavucontrol
    wireplumber
    nextdns
    killall
  ];
  nix.settings.allowed-users = [ "@wheel" ];
    # - SHELL - #
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
    # - VMS - #
  virtualisation.libvirtd.enable = true;
    # - FONTS - #
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    ubuntu_font_family
    dina-font
    proggyfonts
    tt2020
    monocraft
    comic-mono
    comic-relief
    open-dyslexic
  ];
    # - BOOTLOADER - #
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
    # - PLYMOUTH - #
  boot.plymouth = {
    enable = true;
    #theme = "catppuccin-mocha";
    themePackages = [ pkgs.catppuccin-plymouth ];
  };
    # - NETWORKING - #
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    enableIPv6 = false;
    firewall.enable = true;
  };
  services.nextdns = {
    enable = true;
    arguments = [ "-profile" "96ff46" "-cache-size" "10MB" ];
  };
    # - SETTINGS - #
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
    # - GRAPHICS - #
  services.xserver = {
    enable = true;
    layout = "de";
    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
  };
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  xdg.portal.wlr.enable = true;
    # - AUDIO - #
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
    # - SYSTEM - #
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";

  system.nixos.label = "MeowOS-1.0.0-MaineCoon";
    # CHANGELOG:
    #   - MeowOS v.1.0.0 | MaineCoon
    #     » Initial Release
}
