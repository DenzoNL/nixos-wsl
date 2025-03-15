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
    gitkraken
    k9s
    kubectl
    kubernetes-helm
    nixd
    nixfmt
  ];

  # Enable direnv
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      k = "kubectl";
      tf = "terraform";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
       }
       {
         name = "powerlevel10k-config";
         src = lib.cleanSource ./p10k-config;
         file = "p10k.zsh";
       }
    ];
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
  };
}