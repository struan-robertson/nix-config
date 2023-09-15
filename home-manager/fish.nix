
programs.fish = {
  enable = true;

  functions = {
    fish_user_key_binding = ''
      fish_vi_key_bindings
      bind -M insert -m default jk backward-char force-repaint
    '';
  }; 

  shellInit = { "set fish_key_bindings fish_user_key_bindings"; };
}
