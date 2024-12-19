{ config, pkgs, lib, user, inputs, ... }:

{
  nixpkgs.overlays = [ 
    # QUTEBROWSER 

    (final: prev: { 
      qutebrowser = prev.qutebrowser.override { 
        enableWideVine = true; 
      }; 
    }) 

    # CHROME 
    (final: prev: { 
      chromium = prev.chromium.override { 
        commandLineArgs = "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing"; 
      }; 
    })
  ]; 
  
  home.packages = with pkgs; [
    tridactyl-native librewolf
    qutebrowser
  ];

  # LIBREWOLF


  # After changing to this librwwolf started crashing
  # programs.librewolf = {
  #   # TODO: update librewolf declaration to include firefox options
  #   enable = true;
  #   settings = {
  #     "font.size.variable.x-western" = "20";
  #     "browser.toolbars.bookmarks.visibility" = "never";
  #     "privacy.resisttFingerprinting.letterboxing" =  true;
  #     "network.http.referer.XOriginPolicy" = "2";
  #     "privacy.clearOnShutdown.history" = false;
  #     "privacy.clearOnShutdown.downloads" = true;
  #     "privacy.clearOnShutdown.cookies" = true;
  #     "gfx.webrender.software.opengl" = false;
  #     "webgl.disabled" = true;
  #   };
  # };

  home.file.".librewolf/librewolf.overrides.cfg".text = ''
    defaultPref("font.size.variable.x-western",20);
    defaultPref("browser.toolbars.bookmarks.visibility","never");
    defaultPref("privacy.resisttFingerprinting.letterboxing", true);
    defaultPref("network.http.referer.XOriginPolicy",2);
    defaultPref("privacy.clearOnShutdown.history",false);
    defaultPref("privacy.clearOnShutdown.downloads",true);
    defaultPref("privacy.clearOnShutdown.cookies",true);
    defaultPref("gfx.webrender.software.opengl",false);
    defaultPref("webgl.disabled",true);


    pref("font.size.variable.x-western",20);
    pref("browser.toolbars.bookmarks.visibility","never");
    pref("privacy.resisttFingerprinting.letterboxing", true);
    pref("network.http.referer.XOriginPolicy",2);
    pref("privacy.clearOnShutdown.history",false);
    pref("privacy.clearOnShutdown.downloads",true);
    pref("privacy.clearOnShutdown.cookies",true);
    pref("gfx.webrender.software.opengl",false);
    pref("webgl.disabled",true);
    '';

  home.sessionVariables = { DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";};

  # FIREFOX
  programs.firefox = {
    enable = true;
    profiles.${user.name} = { 
      isDefault = true; 

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        multi-account-containers

        ublock-origin
        privacy-badger
        sponsorblock
        youtube-shorts-block
        canvasblocker
        decentraleyes
        disconnect

        darkreader
        proton-pass
        # yomitan
        languagetool
        dictionaries

        tridactyl

        augmented-steam
        indie-wiki-buddy

        h264ify
        plasma-integration
      ];

      settings = { 
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.bookmarks.addedImportButton" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.download.panel.shown" = true;
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "extensions.pocket.enabled" = false;
        "extensions.autoDisableScopes" = 0;
      };

      search = {
        default = "DuckDuckGo";

        engines = {

          "Kagi" = {
            urls = [{ template = "https://kagi.com/search?q={searchTerms}"; }];
            icon = "https://kagi.com/favicon.ico";
            definedAliases = [ "@k" "kagi" ];
          };
          
         "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Jisho" = {
            urls = [{ template = "https://jisho.org/search/{searchTerms}"; }];
            icon = "https://jisho.org/favicon.ico";
            definedAliases = [ "@j" ];
          };

          "Amazon" = {
            urls = [{ template = "https://www.amazon.co.jp/s?k={searchTerms}"; }];
            icon = "https://www.amazon.com/favicon.ico";
            definedAliases = [ "@a" ];
          };

          "Bing".metaData.hidden = true;
          # builtin engines only support specifying one additional alias
          "Google".metaData.alias = "@g"; 
          "DuckDuckGo".metaData.alias = "@d";
        };

        force = true;
      };

      userContent = ''
        /* Hide scrollbar in FF Quantum */
        *{scrollbar-width:none !important}
        ''; 
        
      containers = { 
        # icons:
        # "briefcase", "cart", "circle", "dollar", "fence", "fingerprint",
        # "gift", "vacation", "food", "fruit", "pet", "tree", "chill"

        # colors:
        # "blue", "turquoise", "green", "yellow", "orange", 
        # "red", "pink", "purple", "toolbar"

        anon = { color = "purple"; icon = "fingerprint"; id = 1; };
        utzuro = { color = "pink"; icon = "briefcase"; id = 2; };
        adept = { color = "orange"; icon = "pet"; id = 3; };
        shopping = { color = "green"; icon = "cart"; id = 4; };
        blocked = { color = "red"; icon = "fence"; id = 5; };
        gig = { color = "green"; icon = "dollar"; id = 6; };
      };

      bookmarks = [ 
        { name = "NixOS"; url = "https://nixos.org"; }
      ];
    };
  };
}


