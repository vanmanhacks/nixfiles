{ config, pkgs, lib, ... }:

{
  programs.zellij = {
    enable = true;

    # ── Appearance ──────────────────────────────────────────────
    settings = {
      theme = "nord";
      pane_frames = false; # cleaner look (tmux-like, no pane borders)
      default_shell = "zsh"; # match your shell
      mouse_mode = true;
      copy_command = "wl-copy"; # Wayland clipboard (change to xclip for X11)
      scroll_buffer_size = 10000;
      copy_on_select = true; # select-to-copy like tmux-yank
      disable_automatic_asset_installation = true; # NixOS manages this

      # ── Status Bar ───────────────────────────────────────────
      default_mode = "tmux"; # "locked" = normal mode (keys locked, prefix to unlock)
      # alternative: "normal" = keys always active (like tmux)

      # ── Session Behaviour ────────────────────────────────────
      # Sessions survive detach/reattach (like tmux).
      # NO auto-restore across reboots (tmux-continuum equivalent doesn't exist yet).
      # Workaround: create a layout file for your standard workspace.
      session_serialization = true;

      # ── Keybinding Strategy ──────────────────────────────────
      # OPTION A: Zellij native (Ctrl+o prefix) — best for mobile, on-screen hints
      #   Ctrl+o d → new pane right
      #   Ctrl+o e → new pane down
      #   Ctrl+o n → new tab
      #   Ctrl+o w → session picker
      #   Ctrl+o Ctrl+g → lock UI (prevents accidental input — great on mobile)
      #
      # OPTION B: tmux mode (Ctrl+b prefix) — identical muscle memory
      #   Ctrl+b c → new tab
      #   Ctrl+b " → split horizontal (Zellij: new pane down)
      #   Ctrl+b % → split vertical (Zellij: new pane right)
      #   Ctrl+b x → close pane
      #   Ctrl+b d → detach
      #   Ctrl+b [ → scroll/search mode
      #   Ctrl+b S → session picker
      #
      # Below uses Zellij native. To switch to tmux-mode, uncomment:
      # default_mode = "tmux";

      # ── Layout Defaults ──────────────────────────────────────
      # When attaching with no layout, start with one clean pane.
      default_layout = "compact"; # "compact" = minimal chrome, max screen space

      # ── Pane defaults ────────────────────────────────────────
      simplified_ui = true; # hides less-used UI elements
    };

    # ── Zellij-native keybind config (KDL) ─────────────────────
    # Uncomment and customize if you want Zellij-native keys.
    # This gives you on-screen Ctrl+o hints — the killer mobile feature.
    #
    # extraConfig = ''
    #   keybinds clear-defaults=true {
    #     normal {
    #       // prefix-less shortcuts (optional)
    #       bind "Ctrl n" { NewTab; }
    #     }
    #     locked {
    #       bind "Ctrl g" { SwitchToMode "Normal"; }
    #     }
    #     resize {
    #       bind "Esc" { SwitchToMode "Normal"; }
    #     }
    #     pane {
    #       bind "Esc" { SwitchToMode "Normal"; }
    #     }
    #     tab {
    #       bind "Esc" { SwitchToMode "Normal"; }
    #     }
    #     scroll {
    #       bind "Esc" { SwitchToMode "Normal"; }
    #     }
    #     session {
    #       bind "Esc" { SwitchToMode "Normal"; }
    #     }
    #   }
    # '';

    # ── Standard Layout File (optional) ────────────────────────
    # Create ~/.config/zellij/layouts/default.kdl for auto-restore:
    #
    #   layout {
    #     pane size=1 borderless=true {
    #       plugin location="zellij:status-bar"
    #     }
    #     pane
    #   }
    #
    # Then launch with: zellij --layout default
  };
}

# ═══════════════════════════════════════════════════════════════
# MIGRATION NOTES: tmux → zellij
# ═══════════════════════════════════════════════════════════════
#
# Feature parity with your tmux.nix:
#   tmux plugin          → zellij native
#   ─────────────────────────────────────
#   sensible             → sane defaults (built-in)
#   nord                 → theme = "nord"
#   yank                 → copy_on_select = true + copy_command
#   sysstat              → status-bar plugin (built-in)
#   continuum            → NO EQUIVALENT (sessions survive detach, not reboot)
#   sessionx             → Ctrl+o w (built-in session picker)
#   better-mouse-mode    → mouse_mode = true
#   baseIndex = 1        → tabs start at 1 by default in Zellij
#   clock24 = true        → default (configurable in status-bar)
#
# What you gain:
#   • On-screen keybinding hints (prefix → labeled keys appear)
#   • Floating panes (Ctrl+o p → pop-up terminal anywhere)
#   • Lock mode (Ctrl+o Ctrl+g → freeze UI, prevents fat-finger destruction)
#   • Strider file browser (Ctrl+o f)
#   • No plugin compatibility issues on NixOS updates
#   • Written in Rust
#
# Recommended trial:
#   1. nix-shell -p zellij
#   2. zellij (takes 30 seconds to learn — follow the hints)
#   3. If you want tmux keybinds: set default_mode = "tmux"
#   4. Keep tmux.nix in place; switch back with tmux attach if needed
