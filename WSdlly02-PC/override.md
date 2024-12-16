
```nix
# configuration.nix
{
# ...

environment = {
systemPackages = [
pkgs.alsa-ucm-conf.overrideAttrs (old: {
wttsrc = (fetchFromGitHub {
owner = "WeirdTreeThing";
repo = "chromebook-ucm-conf";
rev = "484f5c581ac45c4ee6cfaf62bdecedfa44353424";
hash = "sha256-Jal+VfxrPSAPg9ZR+e3QCy4jgSWT4sSShxICKTGJvAI=";
});
installPhase = ''
runHook preInstall

mkdir -p $out/share/alsa
cp -r ucm ucm2 $out/share/alsa

mkdir -p $out/share/alsa/ucm2/conf.d
cp -r $wttsrc/{hdmi,dmic}-common $wttsrc/GENERATION/* $out/share/alsa/ucm2/conf.d

runHook postInstall
'';
})
];
sessionVariables = {
ALSA_CONFIG_UCM2 = "${pkgs.alsa-ucm-conf}/share/alsa/ucm2";
};
};
}
```
