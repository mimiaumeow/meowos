# MeowOS
# by mia | mimiaumeow.github.io

# TO-DO:
# - Install nixGL
# - Fix Aseprite Theme
# - Find Alternatives to GUI Apps
# - Login Manager Theme
# - Plymouth Theme
# - FocusWriter Theme (no Wallpaper, not enabled by Default)
# - Configure systemd-boot
# - Full Disk Encryption
# - BTRFS
# - Amnesia

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
      pkgs.appimage-run
      pkgs.librewolf
      pkgs.keepassxc
      pkgs.alacritty
      pkgs.gnome.nautilus
      (pkgs.discord.override {
        withVencord=true;
      })
      pkgs.steam
      pkgs.lutris
      pkgs.heroic
      pkgs.prismlauncher
      pkgs.krita
      pkgs.aseprite
      pkgs.inkscape
      pkgs.scribus
      pkgs.blender
      pkgs.gnome.gnome-calculator
      pkgs.libreoffice
      pkgs.focuswriter
      pkgs.virt-manager
      pkgs.godot
    ];

    # - HOME FOLDER - #
    home.file."media/.media".text = ''
      media
    '';
    home.file."projects/.projects".text = ''
      projects
    '';

    # - .c FOLDER - #
    home.file.".c/Games/.Games".text = ''
      Games
    '';
    home.file.".c/Games/Heroic/.Heroic".text = ''
      Heroic
    '';
    home.file.".c/Games/Lutris/.Lutris".text = ''
      Lutris
    '';
    home.file.".c/Minecraft/.Minecraft".text = ''
      Minecraft
    '';
    home.file.".c/Minecraft/docs/.docs".text = ''
      docs
    '';
    home.file.".c/Minecraft/downloads/.downloads".text = ''
      downloads
    '';
    home.file.".c/Minecraft/instances/.instances".text = ''
      instances
    '';
    home.file.".c/Minecraft/mods/.mods".text = ''
      mods
    '';
    # Archipelago
    home.file.".c/Archipelago/.Archipelago".text = ''
      Archipelago
    '';
    home.file.".c/Archipelago/Archipelago.AppImage" = {
      source = builtins.fetchurl {
        url = "https://github.com/ArchipelagoMW/Archipelago/releases/download/0.4.3/Archipelago_0.4.3_linux-x86_64.AppImage";
      };
    };

    # - CONFIGS - #
    #   KRITA
    home.file.".config/kritashortcutsrc".text = ''
      [Shortcuts]
      KritaFill/KisToolGradient=none
      KritaSelected/KisToolColorSampler=D
      KritaShape/KisToolBrush=P
      PanTool=G
      convert-to-path=none
      reset_fg_bg=none
    '';
    #   ASEPRITE
    home.file.".config/aseprite/data/skins/catppuccin-theme-mocha/package.json" = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/sharkked/catppuccin-aseprite/main/themes/mocha/catppuccin-theme-mocha/package.json";
      };
    };
    home.file.".config/aseprite/data/skins/catppuccin-theme-mocha/sheet.aseprite-data" = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/sharkked/catppuccin-aseprite/main/themes/mocha/catppuccin-theme-mocha/sheet.aseprite-data";
      };
    };
    home.file.".config/aseprite/data/skins/catppuccin-theme-mocha/sheet.png" = {
      source = builtins.fetchurl {
        url = "https://github.com/sharkked/catppuccin-aseprite/blob/c10e30ea04c3e0c41604847c363bf6a69918ca54/themes/mocha/catppuccin-theme-mocha/sheet.png?raw=true";
      };
    };
    home.file.".config/aseprite/data/skins/catppuccin-theme-mocha/theme.xml" = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/sharkked/catppuccin-aseprite/main/themes/mocha/catppuccin-theme-mocha/theme.xml";
      };
    };
    home.file.".config/aseprite/aseprite.ini".text = ''
      [GfxMode]
      Maximized = true
      Width = 1920
      Height = 1080
      WindowLayout = 2 1280 23
      [MiniEditor]
      WindowPos = 400 256 240 132
      Enabled = false
      [general]
      screen_scale = 2
      visible_timeline = true
      [layout:main_window]
      color_bar_splitter = 94
      palette_spectrum_splitter = 80.6005
      timeline_splitter = 75
      [color_bar]
      fg_color = rgb{219,230,235,255}
      [tool.eraser.brush]
      size = 1
      [tool.pencil.brush]
      size = 1
    '';
      #[theme]
      #selected = catppuccin-theme-mocha
    home.file.".config/aseprite/user.aseprite-keys".text = ''
      <?xml version="1.0" encoding="utf-8" ?>
      <keyboard version="1">
        <commands>
          <key command="FrameProperties" shortcut="P" removed="true">
            <param name="frame" value="current" />
          </key>
        </commands>
        <tools>
          <key tool="pencil" shortcut="B" removed="true" />
          <key tool="pencil" shortcut="P" />
          <key tool="eraser" shortcut="E" />
          <key tool="eyedropper" shortcut="I" removed="true" />
          <key tool="hand" shortcut="H" removed="true" />
          <key tool="hand" shortcut="G" />
          <key tool="paint_bucket" shortcut="G" removed="true" />
          <key tool="contour" shortcut="D" removed="true" />
        </tools>
        <quicktools>
          <key tool="eyedropper" shortcut="Alt" removed="true" />
          <key tool="eyedropper" shortcut="D" />
        </quicktools>
        <actions />
      </keyboard>
    '';
    #   FOCUSWRITER
    home.file.".config/GottCode/FocusWriter-old.conf".text = ''
      [Edit]
      AlwaysCenter=false
      BlockCursor=false
      SmartDoubleQuotes=0
      SmartQuotes=true
      SmartSingleQuotes=1
      SmoothFonts=true
      TypewriterSounds=false
      [Goal]
      History=false
      Minutes=30
      StreakMinimum=100
      Streaks=true
      Type=0
      Words=1000
      [ImageButton]
      Location=/home/mia
      [Preferences]
      Size=@Size(650 560)
      [Save]
      Active=0
      Current=@Invalid()
      DefaultFormat=odt
      Positions=@Invalid()
      RememberPositions=true
      WriteBOM=true
      [SceneList]
      Divider=##
      Width=336
      [Shortcuts]
      FocusedText1=
      FocusedText2=
      FocusedText3=
      FormatBlockHeading1=Ctrl+Shift+1
      FormatBlockHeading2=Ctrl+Shift+2
      FormatBlockHeading3=Ctrl+Shift+3
      FormatBlockHeading4=Ctrl+Shift+4
      FormatBlockHeading5=Ctrl+Shift+5
      FormatBlockHeading6=\x17c0\xdc53
      SaveAs=Ctrl+Shift+S
      [Spelling]
      HighlightMisspelled=false
      IgnoreNumbers=false
      IgnoreUppercase=false
      Language=
      [Stats]
      CharactersPerPage=1500
      PageSizeType=2
      ParagraphsPerPage=5
      ShowCharacters=true
      ShowPages=true
      ShowParagraphs=true
      ShowWords=true
      WordcountType=0
      WordsPerPage=250
      [SymbolsDialog]
      Shortcuts="@Variant(\0\0\0\x1c\0\0\0\x4\0\0\0\b\0\x32\0\x30\0\x31\0\x39\0\0\0\n\0\0\0\x18\0\x43\0t\0r\0l\0+\0S\0h\0i\0\x66\0t\0+\0=\0\0\0\b\0\x32\0\x30\0\x31\0\x34\0\0\0\n\0\0\0\f\0\x43\0t\0r\0l\0+\0-\0\0\0\b\0\x32\0\x30\0\x32\0\x36\0\0\0\n\0\0\0\f\0\x43\0t\0r\0l\0+\0.\0\0\0\b\0\x32\0\x30\0\x32\0\x32\0\0\0\n\0\0\0\f\0\x43\0t\0r\0l\0+\0*)"
      [ThemeDialog]
      Size=@Size(1049 452)
      [ThemeManager]
      Location=/home/mia
      Size=@Size(673 490)
      Theme=catppuccin
      ThemeDefault=true
      [Toolbar]
      Actions=New, Open, Save, SaveAs, |, Undo, Redo, |, Cut, Copy, Paste, |, Find, Replace, |, ^Themes, ^About, ^AboutQt, FormatAlignCenter, FormatAlignJustify, FormatAlignLeft, FormatAlignRight, FormatIndentIncrease, FormatIndentDecrease, ^PreferencesLocale, FormatBold, ^Close, ^DailyProgress, ^FindNext, ^FindPrevious, ^Fullscreen, FormatItalic, ^FormatDirectionLTR, ^ManageSessions, ^Minimize, ^NewSession, ^PageSetup, ^PasteUnformatted, ^Preferences, ^Print, ^Quit, ^Reload, ^Rename, ^FormatDirectionRTL, ^SaveAll, ^SelectAll, ^SelectScene, ^SetDefaultLanguage, ^CheckSpelling, FormatUnderline, FormatStrikeOut, FormatSubScript, FormatSuperScript, ^Symbols, ^Timers
      Style=0
      [View]
      AlwaysShowFooter=false
      AlwaysShowHeader=false
      AlwaysShowScrollbar=false
      [Window]
      FocusedText=0
      Fullscreen=true
    '';
    home.file.".local/share/GottCode/FocusWriter/Themes/catppuccin.theme".text = ''
      [General]
      LoadColor=#d8aae2
      Name=Catppuccin (MeowOS)
      [Background]
      Color=#666666
      ImageFile=~/.wallpaper.png
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
    #   KEEPASSXC
    home.file.".config/keepassxc/keepassxc.ini".text = ''
      [General]
      ConfigVersion=2
      [GUI]
      ApplicationTheme=dark
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
        clock = "date +'%A%n%d.%m.%Y%n%u %H:%M'";
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
      initExtra = "clear && date +'%A%n%d.%m.%Y%n%u %H:%M'";
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
          background: "#1E1E2E"
          foreground: "#CDD6F4"
          dim_foreground: "#CDD6F4"
          bright_foreground: "#CDD6F4"
        cursor:
          text: "#1E1E2E"
          cursor: "#F5E0DC"
        vi_mode_cursor:
          text: "#1E1E2E"
          cursor: "#B4BEFE"
        search:
          matches:
            foreground: "#1E1E2E"
            background: "#A6ADC8"
          focused_match:
            foreground: "#1E1E2E"
            background: "#A6E3A1"
          footer_bar:
            foreground: "#1E1E2E"
            background: "#A6ADC8"
          hints:
            start:
              foreground: "#1E1E2E"
              background: "#F9E2AF"
            end:
              foreground: "#1E1E2E"
              background: "#A6ADC8"
          selection:
            text: "#1E1E2E"
            background: "#F5E0DC"
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
    #   LIBREWOLF
      # Configuration with other Syncing Methods;
      # Everything that cant be Synced will be here:
      # IMPROVEDTUBE 
    home.file.".config/librewolfmanual/improvedtube.json".text = ''
      {"add_scroll_to_top":true,"always_show_progress_bar":false,"below_player_pip":false,"below    _player_screenshot":true,"channel_compact_theme":true,"channel_default_tab":"/videos","cha    nnel_hide_featured_content":true,"channel_play_all_button":true,"channel_trailer_autoplay"    :false,"channel_videos_count":false,"collapse_of_subscription_sections":true,"comments_sid    ebar":true,"comments_sidebar_simple":false,"day_of_week":true,"description":"expanded","du    ration_with_speed":true,"embeddedHidePauseOverlay":true,"embeddedHideShare":true,"embedded    HideYoutubeLogo":true,"forced_theater_mode":false,"header_hide_country_code":true,"header_    hide_right_buttons":true,"header_improve_logo":true,"header_transparent":true,"hide_animat    ed_thumbnails":true,"hide_author_avatars":false,"hide_clip_button":"icons_only","hide_deta    ils":false,"hide_download_button":"hidden","hide_footer":true,"hide_gradient_bottom":false    ,"hide_more_button":false,"hide_save_button":"icons_only","hide_scroll_for_details":true,"    hide_share_button":"icons_only","hide_shorts_remixing":true,"hide_thanks_button":"hidden",    "hide_thumbnail_overlay":false,"hide_views_count":false,"hide_voice_search_button":true,"h    ow_long_ago_the_video_was_uploaded":true,"improvedtube_youtube_icon":"disabled","livechat"    :"collapsed","mini_player":true,"player_autoplay":false,"player_autoplay_button":true,"pla    yer_color":"deep_purple","player_hd_thumbnail":true,"player_hide_annotations":true,"player    _hide_cards":true,"player_hide_endscreen":true,"player_hide_skip_overlay":true,"player_min    iplayer_button":false,"player_previous_button":false,"player_quality":"hd1080","player_rem    aining_duration":true,"player_remote_button":true,"player_repeat_button":true,"player_scre    en_button":false,"player_screenshot_button":true,"player_settings_button":false,"player_sh    ow_cards_on_mouse_hover":true,"player_size":"full_window","player_subtitles_button":false,    "player_transparent_background":true,"player_view_button":false,"player_volume_button":fal    se,"red_dislike_button":true,"related_videos":"collapsed","remove_home_page_shorts":true,"    remove_related_search_results":true,"remove_shorts_reel_search_results":true,"squared_user    _images":false,"theme":"dark","theme_primary_color":[null,null,null],"theme_text_color":[2    5,25,25],"up_next_autoplay":false,"youtube_home_page":"/feed/subscriptions"}
    '';
    # LICHESS ENHANCEMENT
    # about:config | xpinstall.signatures.required = false
    # about:addons | grant permissions
    # Configuration: Neo-Wood; Wallnut
    # I still cant decide whether or not I should use PrettierLichess Custom Board Colors or the Wallnut Board... both are good, but Ill go with Wallnut for now.
    home.file.".config/librewolfmanual/lichessenhancement.zip" = {
      source = builtins.fetchurl {
        url = "https://download1526.mediafire.com/em9mdwix696gfeF1WD39pqymLsCKu9DNfx2bNysL_o_LPSanWuv3NX9VSr8OtLuQ00OEoO1qrrp3YieYGBfM0Gp1RykFpQt5lm1pWXEb6YIht0iGFg-3cIPokUd9OPsTiyxPSFLcfBNu40jcYrT30xpah13LozqKu6aIAnpn/l64yyc3my4pd0dv/lichess_enhancement-4.1.zip";
      };
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
    #     MONITOR & XWAYLAND FIX
      monitor=,highres,auto,1
      env = GDK_SCALE,1
      env = XCURSOR_SIZE,32
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
      bind = $mod, H, exec, discord
      bind = $mod, G, exec, nixGL steam
      bind = $mod, K, exec, krita
      bind = $mod, L, exec, libresprite
      bind = $mod, I, exec, inkscape
      bind = $mod, Z, exec, scribus
      bind = $mod, M, exec, blender
      bind = $mod, C, exec, gnome-calculator
      bind = $mod, O, exec, libreoffice
      bind = $mod, N, exec, focuswriter
      bind = $mod, U, exec, godot
      bind = $mod, V, exec, pavucontrol
      bind = , xf86audioraisevolume, exec, wpctl set-sink-volume @DEFAULT_SINK@ +5% 
      bind = , xf86audiolowervolume, exec, wpctl set-sink-volume @DEFAULT_SINK@ -5% 
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
        kb_options = compose:rctrl
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
    #   DISCORD
    home.file.".config/discord/settings/settings.json".text = ''
      {
        "SKIP_HOST_UPDATE": true,
        "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
        "MIN_WIDTH": 940,
        "MIN_HEIGHT": 500,
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": false,
        "WINDOW_BOUNDS": {
          "x": 12,
          "y": 12,
          "width": 1256,
          "height": 696                 
        },
        "MINIMIZE_TO_TRAY": false,
        "OPEN_ON_STARTUP": false              
      }
    '';
    #   VENCORD
    home.file.".config/Vencord/settings/settings.json".text = ''
    {
    "notifyAboutUpdates": true,
    "autoUpdate": false,
    "autoUpdateNotification": true,
    "useQuickCss": true,
    "themeLinks": [
        "https://github.com/catppuccin/discord/blob/main/themes/mocha.theme.css?raw=1"
    ],
    "enabledThemes": [],
    "enableReactDevtools": false,
    "frameless": false,
    "transparent": false,
    "winCtrlQ": false,
    "macosTranslucency": false,
    "disableMinSize": false,
    "winNativeTitleBar": false,
    "plugins": {
        "BadgeAPI": {
            "enabled": true
        },
        "CommandsAPI": {
            "enabled": true
        },
        "ContextMenuAPI": {
            "enabled": true
        },
        "MemberListDecoratorsAPI": {
            "enabled": false
        },
        "MessageAccessoriesAPI": {
            "enabled": true
        },
        "MessageDecorationsAPI": {
            "enabled": false
        },
        "MessageEventsAPI": {
            "enabled": true
        },
        "MessagePopoverAPI": {
            "enabled": true
        },
        "NoticesAPI": {
            "enabled": true
        },
        "ServerListAPI": {
            "enabled": true
        },
        "SettingsStoreAPI": {
            "enabled": true
        },
        "NoTrack": {
            "enabled": true
        },
        "Settings": {
            "enabled": true,
            "settingsLocation": "aboveActivity"
        },
        "AlwaysAnimate": {
            "enabled": true
        },
        "AlwaysTrust": {
            "enabled": true
        },
        "AnonymiseFileNames": {
            "enabled": false,
            "method": 0,
            "randomisedLength": 7,
            "consistent": "image"
        },
        "BANger": {
            "enabled": false,
            "source": "https://i.imgur.com/wp5q52C.mp4"
        },
        "BetterFolders": {
            "enabled": true,
            "sidebar": true,
            "sidebarAnim": true,
            "closeAllFolders": false,
            "closeAllHomeButton": true,
            "closeOthers": false,
            "forceOpen": false
        },
        "BetterGifAltText": {
            "enabled": true
        },
        "BetterNotesBox": {
            "enabled": true,
            "hide": true,
            "noSpellCheck": true
        },
        "BetterRoleDot": {
            "enabled": true,
            "bothStyles": false
        },
        "BetterUploadButton": {
            "enabled": true
        },
        "BiggerStreamPreview": {
            "enabled": true
        },
        "BlurNSFW": {
            "enabled": true,
            "blurAmount": 10
        },
        "CallTimer": {
            "enabled": true,
            "format": "human"
        },
        "ClearURLs": {
            "enabled": true
        },
        "ColorSighted": {
            "enabled": false
        },
        "ConsoleShortcuts": {
            "enabled": false
        },
        "CopyUserURLs": {
            "enabled": false
        },
        "CrashHandler": {
            "enabled": true
        },
        "CustomRPC": {
            "enabled": false,
            "type": 0,
            "timestampMode": 0
        },
        "Dearrow": {
            "enabled": true
        },
        "DisableDMCallIdle": {
            "enabled": true
        },
        "EmoteCloner": {
            "enabled": true
        },
        "Experiments": {
            "enabled": true,
            "enableIsStaff": false,
            "forceStagingBanner": false
        },
        "F8Break": {
            "enabled": false
        },
        "FakeNitro": {
            "enabled": true,
            "enableEmojiBypass": true,
            "emojiSize": 48,
            "transformEmojis": false,
            "enableStickerBypass": true,
            "stickerSize": 160,
            "transformStickers": false,
            "transformCompoundSentence": false,
            "enableStreamQualityBypass": false
        },
        "FakeProfileThemes": {
            "enabled": false,
            "nitroFirst": true
        },
        "FavoriteEmojiFirst": {
            "enabled": false
        },
        "FavoriteGifSearch": {
            "enabled": false,
            "searchOption": "hostandpath"
        },
        "FixInbox": {
            "enabled": false
        },
        "FixSpotifyEmbeds": {
            "enabled": true,
            "volume": 10
        },
        "ForceOwnerCrown": {
            "enabled": true
        },
        "FriendInvites": {
            "enabled": false
        },
        "GameActivityToggle": {
            "enabled": false
        },
        "GifPaste": {
            "enabled": true
        },
        "GreetStickerPicker": {
            "enabled": true,
            "greetMode": "Greet"
        },
        "HideAttachments": {
            "enabled": false
        },
        "iLoveSpam": {
            "enabled": false
        },
        "IgnoreActivities": {
            "enabled": true
        },
        "ImageZoom": {
            "enabled": true,
            "saveZoomValues": true,
            "preventCarouselFromClosingOnClick": true,
            "invertScroll": true,
            "nearestNeighbour": false,
            "square": false,
            "zoom": 2,
            "size": 100,
            "zoomSpeed": 0.5
        },
        "InvisibleChat": {
            "enabled": false,
            "savedPasswords": "password, Password"
        },
        "KeepCurrentChannel": {
            "enabled": false
        },
        "LastFMRichPresence": {
            "enabled": false
        },
        "LoadingQuotes": {
            "enabled": true
        },
        "MemberCount": {
            "enabled": false
        },
        "MessageClickActions": {
            "enabled": false
        },
        "MessageLinkEmbeds": {
            "enabled": true,
            "automodEmbeds": "never",
            "listMode": "blacklist",
            "idList": ""
        },
        "MessageLogger": {
            "enabled": true,
            "deleteStyle": "overlay",
            "ignoreBots": false,
            "ignoreSelf": false,
            "ignoreUsers": "",
            "ignoreChannels": "",
            "ignoreGuilds": ""
        },
        "MessageTags": {
            "enabled": false
        },
        "MoreCommands": {
            "enabled": false
        },
        "MoreKaomoji": {
            "enabled": true
        },
        "MoreUserTags": {
            "enabled": true,
            "tagSettings": {
                "WEBHOOK": {
                    "text": "Webhook",
                    "showInChat": true,
                    "showInNotChat": true
                },
                "OWNER": {
                    "text": "Owner",
                    "showInChat": true,
                    "showInNotChat": true
                },
                "ADMINISTRATOR": {
                    "text": "Admin",
                    "showInChat": true,
                    "showInNotChat": true
                },
                "MODERATOR_STAFF": {
                    "text": "Staff",
                    "showInChat": true,
                    "showInNotChat": true
                },
                "MODERATOR": {
                    "text": "Mod",
                    "showInChat": true,
                    "showInNotChat": true
                },
                "VOICE_MODERATOR": {
                    "text": "VC Mod",
                    "showInChat": true,
                    "showInNotChat": true
                }
            }
        },
        "Moyai": {
            "enabled": true,
            "volume": 0.1777573429327229,
            "quality": "Normal",
            "triggerWhenUnfocused": true,
            "ignoreBots": true,
            "ignoreBlocked": true
        },
        "MuteNewGuild": {
            "enabled": true,
            "guild": true,
            "everyone": true,
            "role": true
        },
        "MutualGroupDMs": {
            "enabled": true
        },
        "NoBlockedMessages": {
            "enabled": false
        },
        "NoDevtoolsWarning": {
            "enabled": false
        },
        "NoF1": {
            "enabled": false
        },
        "NoPendingCount": {
            "enabled": true,
            "hideFriendRequestsCount": false,
            "hideMessageRequestsCount": false,
            "hidePremiumOffersCount": true
        },
        "NoProfileThemes": {
            "enabled": false
        },
        "NoRPC": {
            "enabled": true
        },
        "NoReplyMention": {
            "enabled": true,
            "userList": "1234567890123445,1234567890123445",
            "shouldPingListed": true,
            "inverseShiftReply": false
        },
        "NoScreensharePreview": {
            "enabled": false
        },
        "NoSystemBadge": {
            "enabled": false
        },
        "NoUnblockToJump": {
            "enabled": true
        },
        "NormalizeMessageLinks": {
            "enabled": true
        },
        "NSFWGateBypass": {
            "enabled": true
        },
        "oneko": {
            "enabled": false
        },
        "OpenInApp": {
            "enabled": false
        },
        "Party mode 🎉": {
            "enabled": false,
            "superIntensePartyMode": 0
        },
        "PermissionsViewer": {
            "enabled": true,
            "permissionsSortOrder": 0,
            "defaultPermissionsDropdownState": false
        },
        "petpet": {
            "enabled": true
        },
        "PictureInPicture": {
            "enabled": true
        },
        "PinDMs": {
            "enabled": true,
            "pinOrder": 1
        },
        "PlainFolderIcon": {
            "enabled": false
        },
        "PlatformIndicators": {
            "enabled": false
        },
        "PreviewMessage": {
            "enabled": true
        },
        "PronounDB": {
            "enabled": false,
            "pronounsFormat": "LOWERCASE",
            "pronounSource": 0,
            "showSelf": true,
            "showInMessages": true,
            "showInProfile": true
        },
        "QuickMention": {
            "enabled": false
        },
        "QuickReply": {
            "enabled": false
        },
        "ReactErrorDecoder": {
            "enabled": false
        },
        "ReadAllNotificationsButton": {
            "enabled": false
        },
        "RelationshipNotifier": {
            "enabled": true,
            "offlineRemovals": true,
            "groups": true,
            "servers": true,
            "friends": true,
            "friendRequestCancels": true
        },
        "RevealAllSpoilers": {
            "enabled": true
        },
        "ReverseImageSearch": {
            "enabled": true
        },
        "ReviewDB": {
            "enabled": false
        },
        "RoleColorEverywhere": {
            "enabled": true,
            "chatMentions": true,
            "memberList": true,
            "voiceUsers": true
        },
        "SearchReply": {
            "enabled": false
        },
        "SecretRingToneEnabler": {
            "enabled": true
        },
        "SendTimestamps": {
            "enabled": true
        },
        "ServerListIndicators": {
            "enabled": false
        },
        "ServerProfile": {
            "enabled": true
        },
        "ShikiCodeblocks": {
            "enabled": true,
            "theme": "https://github.com/catppuccin/vscode/releases/download/v3.6.0/catppuccin-vsc-3.6.0.vsix",
            "tryHljs": "SECONDARY",
            "useDevIcon": "GREYSCALE",
            "bgOpacity": 100
        },
        "ShowAllMessageButtons": {
            "enabled": false
        },
        "ShowConnections": {
            "enabled": false
        },
        "ShowHiddenChannels": {
            "enabled": true,
            "hideUnreads": true,
            "showMode": 1,
            "defaultAllowedUsersAndRolesDropdownState": true
        },
        "ShowMeYourName": {
            "enabled": true,
            "mode": "nick-user",
            "displayNames": false,
            "inReplies": false
        },
        "ShowTimeouts": {
            "enabled": true
        },
        "SilentMessageToggle": {
            "enabled": false,
            "persistState": false,
            "autoDisable": true
        },
        "SilentTyping": {
            "enabled": true,
            "showIcon": true,
            "isEnabled": false
        },
        "SortFriendRequests": {
            "enabled": true,
            "showDates": true
        },
        "SpotifyControls": {
            "enabled": false
        },
        "SpotifyCrack": {
            "enabled": false
        },
        "SpotifyShareCommands": {
            "enabled": false
        },
        "StartupTimings": {
            "enabled": false
        },
        "SupportHelper": {
            "enabled": true
        },
        "TextReplace": {
            "enabled": false
        },
        "ThemeAttributes": {
            "enabled": false
        },
        "TimeBarAllActivities": {
            "enabled": false
        },
        "Translate": {
            "enabled": true,
            "autoTranslate": false,
            "receivedInput": "auto",
            "receivedOutput": "en",
            "sentInput": "auto",
            "sentOutput": "en"
        },
        "TypingIndicator": {
            "enabled": true,
            "includeMutedChannels": false,
            "includeBlockedUsers": true
        },
        "TypingTweaks": {
            "enabled": true,
            "alternativeFormatting": true
        },
        "Unindent": {
            "enabled": false
        },
        "UnsuppressEmbeds": {
            "enabled": false
        },
        "UrbanDictionary": {
            "enabled": false
        },
        "UserVoiceShow": {
            "enabled": true
        },
        "USRBG": {
            "enabled": false
        },
        "ValidUser": {
            "enabled": true
        },
        "VoiceChatDoubleClick": {
            "enabled": true
        },
        "VcNarrator": {
            "enabled": false
        },
        "VencordToolbox": {
            "enabled": false
        },
        "ViewIcons": {
            "enabled": true,
            "format": "png",
            "imgSize": "1024"
        },
        "ViewRaw": {
            "enabled": true
        },
        "VoiceMessages": {
            "enabled": false,
            "noiseSuppression": true,
            "echoCancellation": true
        },
        "VolumeBooster": {
            "enabled": true
        },
        "WhoReacted": {
            "enabled": true
        },
        "Wikisearch": {
            "enabled": false
        }
    },
    "notifications": {
        "timeout": 5000,
        "position": "bottom-right",
        "useNative": "not-focused",
        "logLimit": 50
    },
    "cloud": {
        "authenticated": false,
        "url": "https://api.vencord.dev/",
        "settingsSync": false,
        "settingsSyncVersion": 1694662800288
    }
    }
    '';
    #   STEAMGRIDDB
    home.file.".c/Grids/Minecraft-Java/v.jpg" = {
      source = builtins.fetchurl {
        url = "https://cdn2.steamgriddb.com/file/sgdb-cdn/thumb/0ed5055450adbd836945761a6fa43ee0.jpg";
      };
    };
    home.file.".c/Grids/Minecraft-Java/h.jpg" = {
      source = builtins.fetchurl {
        url = "https://cdn2.steamgriddb.com/file/sgdb-cdn/thumb/b789ce7f0c28e1831a5b0a1998e38d1e.jpg";
      };
    };
    home.file.".c/Grids/Minecraft-Java/o.jpg" = {
      source = builtins.fetchurl {
        url = "https://cdn2.steamgriddb.com/file/sgdb-cdn/hero_thumb/af8d1eb220186400c494db7091e402b0.jpg";
      };
    };
    home.file.".c/Grids/Minecraft-Java/l.png" = {
      source = builtins.fetchurl {
        url = "https://cdn2.steamgriddb.com/file/sgdb-cdn/logo_thumb/d5c1f1a189893daa190f8a0b30ad70f2.png";
      };
    };
    home.file.".c/Grids/Minecraft-Java/i.png" = {
      source = builtins.fetchurl {
        url = "https://cdn2.steamgriddb.com/file/sgdb-cdn/icon/add7a048049671970976f3e18f21ade3/32/256x256.png";
      };
    };
    #   WALLPAPER
    home.file.".wallpaper.png" = {
      source = builtins.fetchurl {
        url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/os/nix-magenta-pink-1920x1080.png?raw=true";
      };
    };

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
    # - JAVA - #
  programs.java.enable = true;
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

  system.nixos.label = "MeowOS-1.6.4-MaineCoon";
    # CHANGELOG:
    #   - MeowOS v.1.6.4
    #     - Download Lichess Enhancement
    #   - MeowOS v.1.6.3
    #     - Export ImprovedTube Config
    #   - MeowOS v.1.6.2
    #     - Download Archipelago
    #     - Set up .c Folder
    #   - MeowOS v.1.6.1
    #     - Download Steam Grids for Minecraft
    #   - MeowOS v.1.6.0
    #     - Enable Java system-wide
    #     - Add pavucontrol Keybind
    #   - MeowOS v.1.5.9
    #     - Add Appimage Support
    #   - MeowOS v.1.5.8
    #     - Add Prism Launcher (Minecraft)
    #   - MeowOS v.1.5.7
    #     - Fix Discord Shortcut
    #   - MeowOS v.1.5.6
    #     - Attempt at fixing Steam
    #   - MeowOS v.1.5.5
    #     - Add Volume Keys
    #   - MeowOS v.1.5.4
    #     - Compose is now Right-Ctrl
    #   - MeowOS v.1.5.3
    #     - Add Compose Key (Currently Right-Alt)
    #   - MeowOS v.1.5.2
    #     - Change Scaling Factor
    #   - MeowOS v.1.5.1
    #     - Fix XWayland Scaling
    #     - Set up Home Folder
    #   - MeowOS v.1.5.0
    #     » MeowOS is now ready to be used.
    #     - Clean Vencord Config
    #   - MeowOS v.1.4.5
    #     - Solve FocusWriter Theme
    #   - MeowOS v.1.4.4
    #     - Change Location of FocusWriter Theme
    #   - MeowOS v.1.4.3
    #     - Fix FocusWriter Theme (temporary Solution)
    #   - MeowOS v.1.4.2
    #     - Test FocusWriter Theme
    #   - MeowOS v.1.4.1
    #     - Discord Config
    #     - Vencord Theming
    #   - MeowOS v.1.4.0
    #     - Vencord Config
    #   - MeowOS v.1.3.6
    #     - Install Vencord
    #     - Disable Aseprite Theme
    #   - MeowOS v.1.3.5
    #     - Download Aseprite Theme directly
    #   - MeowOS v.1.3.4
    #     - Update Aseprite Theme
    #   - MeowOS v.1.3.3
    #     - Switch to Aseprite and fix Theme
    #   - MeowOS v.1.3.2
    #     - Apply Libreprite Theme
    #   - MeowOS v.1.3.1
    #     - Download Libreprite Theme
    #   - MeowOS v.1.3.0
    #     - Download Wallpaper automatically 
    #   - MeowOS v.1.2.2
    #     - Add Libresprite Config
    #   - MeowOS v.1.2.1
    #     - Prepare for Libresprite Config
    #   - MeowOS v.1.2.0
    #     - FocusWriter Config
    #   - MeowOS v.1.1.1
    #     - Fixed Clock Command
    #   - MeowOS v.1.1.0
    #     - Clock Command
    #     - KeePassXC Theme
    #     - Fixed Typos
    #   - MeowOS v.1.0.0 | MaineCoon
    #     » Initial Release
}
