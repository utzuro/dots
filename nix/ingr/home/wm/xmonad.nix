{ pkgs, ... }:

{
  home.file.".xmonad/xmonad.hs".text = ''
    import XMonad
    import XMonad.Config.Xfce
    main = xmonad xfceConfig
    { terminal = "foot"
    , modMask = mod4Mask
    }
    '';
}
