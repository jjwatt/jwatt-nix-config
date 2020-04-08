{ config, pkgs, ... }:

let
  homedir = builtins.getEnv "HOME";
in
{
  # fonts.fontconfig.enable = true;
  # home-manager configuration
  manual.html.enable = true;

  home.packages = with pkgs; [
    antigen
    cheat
    ix
    jq
    meld
    riot-desktop
    ripgrep
  ];

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Jesse Wattenbarger";
    userEmail = "jwatt@broken.watch";
  };

  programs.command-not-found.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableAutojump = true;
    # inherit shellAliases;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # environment.pathsToLink = [ "/share/zsh" ];
    autocd = true;
    history.ignoreSpace = true;
    initExtra = ''
source "${pkgs.antigen}/share/antigen/antigen.zsh"
antigen use oh-my-zsh
antigen bundle git
antigen bundle tmux
antigen bundle colorize
antigen bundle colored-man-pages
antigen bundle fzf
antigen bundle urbainvaes/fzf-marks
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle wfxr/forgit
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle nojhan/liquidprompt
antigen bundle spwhitt/nix-zsh-completions.git
antigen apply
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files";
  };

  programs.skim = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = { theme = "ansi-dark";};
  };

  programs.jq = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 1800;
  };

  programs = {
    alacritty.enable = true;
    info.enable = true;
    man.enable = true;
    readline.enable = true;
  };

  # X setup; untested
  # Will override all desktopmanager sessions with .xsession file
  # I have a workaround on armchair-traveler that, instead, creates
  # the home-manager session as a separate session that you can pick from the greeter.
  # xsession = {
  #   enable = true;
  #   windowManager.xmonad = {
  #     enable = true;
  #     enableContribAndExtras = true;
  #     # config =
  #   };
  # }

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
}
