# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "denzo";
  wsl.startMenuLaunchers = true;
  
  users.users.denzo.shell = pkgs.zsh;
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  # Enable nix flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Required for configuring binary caches with cachix
  nix.settings.trusted-users = [ "root" "denzo" ];

  # Prevent OOMkills by limiting the amount of concurrency while compiling
  nix.settings.cores = 12;

  environment.systemPackages = with pkgs; [
    git
    htop
    wget
  ];

  # Workaroound for VSCode Remote Server
  programs.nix-ld = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "CascadiaMono" ]; })
  ];

  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos-wsl";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
