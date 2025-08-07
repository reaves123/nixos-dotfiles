{ config, pkgs, ... }:
let
  # Import stable packages as overlay
  stable = import <nixpkgs-stable> { 
    system = "x86_64-linux"; 
    config.allowUnfree = true; 
  };
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  users.user.andiboegl = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$6$zgwGRjH7dhaftHHu$DrRv7Q3.m5ENemSGgrnxAHgM4S6Pefveum1yi/ll2T.lCpCrOXFWdzZJPW6XNKYqLqWxcBMAAilK2/tJPQXBe0"
  };

# Most packages from unstable
  environment.systemPackages = with pkgs; [
    git
    neovim
    vim
    bat
    htop
    btop
    lf
    wget
    curl
    lazygit
    tealdeer
    tree
   ];

   networking.networkmanager.enable = true;
   networking.firewall.enable = true;

   services.openssh.enable = true;

   nix.settings.experimental-features = ["nix-command" "flakes"];

}
