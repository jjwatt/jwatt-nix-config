{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  manual.html.enable = true;

  home.packages = with pkgs; [
    jq
    ripgrep
    antigen
    alacritty
    i3lock
    networkmanager_dmenu
    networkmanagerapplet
  ];

  services.network-manager-applet.enable = true;

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Jesse Wattenbarger";
    userEmail = "jwatt@broken.watch";
  };

  programs.command-not-found.enable = true;
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
      antigen bundle zsh-users/zaw
      antigen bundle command-not-found
      antigen bundle nojhan/liquidprompt
      antigen bundle spwhitt/nix-zsh-completions.git
      antigen apply
      antigen theme agnoster
          '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  fonts.fontconfig.enable = true;

  programs.alacritty = { enable = true; };

  programs.lesspipe.enable = true;

  programs.info.enable = true;
  programs.man.enable = true;

  programs.feh.enable = true;

  # OPAM Ocaml
  programs.opam = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.readline.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zathura.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 1800;
  };

  # X setup; untested
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./conf/xmonad.hs;
    };
  };

  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
  };

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
