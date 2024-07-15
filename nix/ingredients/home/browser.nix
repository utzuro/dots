{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [ 
    librewolf 
    # ungoogled-chromium # doesn't work for some reason
    (chromium.override {
      commandLineArgs = 
      "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --disable-gpu-compositing";
    })
  ];

  home.sessionVariables = { DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";};

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
}
