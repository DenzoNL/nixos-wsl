{ pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "denzo";
  home.homeDirectory = "/home/denzo";

  home.sessionPath = [
    "/home/denzo/.cargo/bin"
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    argocd
    awscli2
    cachix
    eza
    gcc
    gitkraken
    k9s
    kubectl
    kubernetes-helm
    nixd
    nixfmt
    openssl
    pkg-config
    rustup
  ];

  # Enable direnv
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      # Kubernetes aliases
      k = "kubectl";
      kc = "kubectx";
      kn = "kubens";
      tf = "terraform";
      
      # Modern replacements for ls
      ls = "exa --icons";
      ll = "exa -l --icons --git";
      la = "exa -la --icons --git";
      lt = "exa --tree --level=2 --icons";
      lta = "exa --tree --level=2 --icons --all";
    };
  };

  # Enable starship prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command_timeout = 1000;
      aws.disabled = true;
    };
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
  };
}