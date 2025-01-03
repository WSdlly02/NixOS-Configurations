{pkgs, ...}: {
  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      {
        name = "Sarasa Fixed SC Semibold";
        package = pkgs.sarasa-gothic;
      }
    ];
    extraConfig = "font-size=18";
  };
}
