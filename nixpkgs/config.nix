{ pkgs, ... }:
{ 
	allowUnfree = true;
	environment.systemPackages = with pkgs; [
  	  wineWowPackages.staging
	];
  	oraclejdk.accept_license = true;
}
