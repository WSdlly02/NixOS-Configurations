{
  networking.resolvconf = {
    enable = true;
    useLocalResolver = true;
    dnsSingleRequest = true;
  };
}
