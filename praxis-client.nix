{ config, pkgs, ...}:
{
  home.packages = with pkgs; [
    remmina
    
  ];
  home.option.services.remmina.enable = true;
}
