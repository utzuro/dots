{ pkgs, lib, ...}:

{

  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;

    serverProperties = {
      gamemode = "survival";
      difficutly = "hard";
      simulation-distance = 10;
      level-seed = 4;
      server-port = 25565;
    };

    # provide the id later
    whitelist = {
      # void = "user-id";
    };

    # I have no clue what it does
    jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
  };

}
