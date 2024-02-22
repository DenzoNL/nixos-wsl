{ lib, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];

  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    "--write-kubeconfig-mode=644" # Allow kubectl to read /etc/rancher/k3s/k3s.yaml
  ];

  environment.systemPackages = with pkgs; [ 
    k3s
    kubernetes-helm
  ];

  # Disable k3s from running on start and hogging resources when unnecessary
  systemd.services.k3s.wantedBy = lib.mkForce [];
}