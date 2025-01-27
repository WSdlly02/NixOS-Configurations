{
  config,
  lib,
  ...
}:
{
  users.users.wsdlly02 = lib.mkIf (config.system.name != "Lily-PC") {
    isNormalUser = true;
    uid = 1000;
    group = "wheel";
    linger = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") true;
    extraGroups = [
      "wsdlly02"
      "users"
      "adbusers"
      "audio"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkH7l0JnwQeP+cmD+ty29i0kdxHdvnvedkiXKcp8dCYRYAoGBIS6FIzD6p058cNwp1DDHN+TTrlNZz9DEizKqbS1SOPJyiWrln6lx3jh9p/AD1pbPRjsgVLzvdBS6bJ6NgtXe2q0bV4UgGktVi6VxDAt4jBQPsUKfyGYx9hh95xeWjvt9AEYcD2hOak9bBRHkE4IQcus5xV1kXNSiVec0DMhB2IObADbx+6H4C+oIIAxVccr+SOivwrSgwmn9XhQ0VgopJomVKg9zmlr7idorwmDZdIsMmpeU346Gu2Piq+Amvn1FM7H37ThBNx81dUO18UZ/gw35zT7G6Hh4CisYFDJWocKfYKMdT4IdzxcyOWkUr3PSfcpOUc+60h+BlpI0ogxYRoXM6R9bWRGYM3x26hRrfcBR8fwTepTa9H+Vz70KNJh4qNrHuMICnyerX+h9igkVXoysPjbzfqidGPzLIbbi+iUU56/8C4JGL2haEppoZgq/bx1Lo5rv1BT7Q732BkhcnS96vaDqsAffAKupHWQ1eRFZ9uId8uRTNbKZmstgKJthcoSdizrbXvlx7b3Kzob9Y4mix9tlUU2Z5i5sm2FFa/AYfTNrLVg6jA4fSrB0vKRyeCaBBzHOhwPOIWZAa0MG/2LZ40M2jT3270HCToHH3kBCMQthByCos20h/IQ== wsdlly02@WSdlly02-PC"
    ];
  };
  programs.lazygit.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      id-generator = prev.writeShellScriptBin "id-generator" ''
        sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
        echo $1 >> ~/Documents/id-list.txt
        echo $sha512ID >> ~/Documents/id-list.txt
        echo $sha512ID
      '';
    })
  ];
  # It shouldn't be a global package
}
