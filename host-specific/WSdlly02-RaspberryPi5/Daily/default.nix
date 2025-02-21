{ pkgs, ... }:
{
  imports = [
    ./home-manager
  ];
  programs.nix-ld.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      fastfetch
      # id-generator is in home-manager
      ncdu
    ];
  };
  users.users.will117 = {
    #### WILL117
    isNormalUser = true;
    uid = 1001;
    # group = "wheel"; He is not admin
    linger = true;
    extraGroups = [
      "will117"
      "users"
      "adbusers"
      "audio"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsr3qLnTXRUPFhKURFV6EtjoCDXo8itVBU7SvC9c9f0UQsm5m2Dq+NL5XLsqF6FVA/qxJnfJ8MEwlkkDPSxhOrp2zsOBfra7JqC0uTzY1t7urMhIOGeD/18n70GPPXYMMXYP+4MU0NDHALB+oS2LoKPzwnTnS58gOwj4t1iU6WL+CzX9bF89mQJA+ljafEiXemRhuOq7/cgwECCl5+Ef3kQwLEoQYTOvsjhXTMiHIc/HE9tAf6NHXjluBg0Zzo3+GQ8sFPROiXiweC2u1iSt/KtAq6zeA36E/3C2OC7dVpw7vbU84C+qkP5Rxp12EnulrgkPRZbUReRQY+GE69Ry7wHFXDQjSVu7mtrXAXSHyLqTkpZzKZkq5BJQTZJfsWSERWZkUWYt7GcwPvlPTclpFoVotFVYGBywSvXy6iQ6sh+DqS33umWbtWmUsLw+IcIRyo4ssNfdl6PFXI3TKjZHnZGXGgPj4Wk4eFvtrRGi23oaSMHYZaT/AvDyL25ORJxVTrWPX3di8qWhpxCPIbhrVIDvwJF5UKe9KFrmgNAORtsIzhIAjSHW9HQswj1LXNwNk5hWnM+aV2tBGSk4z5DH2d5USrMhze+6dT4YHk6g7fK+PvGp/21v+cuLU40GuwG1D2uDKpyQX4C21LE4ODcew+M6oV5onVuHwYEZJViiqZtQ== will117"
    ];
  };
}
