{
  programs.fish = {
    enable = true;

    functions = {
      fish_user_key_bindings = ''
        fish_vi_key_bindings
        bind -M insert -m default jk backward-char force-repaint
      '';

      n = {
        wraps = "n";
        description = "support nnn quit and change directory";
        body = ''
         # Block nesting of nnn in subshells
          if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
              echo "nnn is already running"
              return
          end

          # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
          # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
          # see. To cd on quit only on ^G, remove the "-x" from both lines below,
          # without changing the paths.
          if test -n "$XDG_CONFIG_HOME"
              set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
          else
              set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
          end

          # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
          # stty start undef
          # stty stop undef
          # stty lwrap undef
          # stty lnext undef

          # The command function allows one to alias this function to `nnn` without
          # making an infinitely recursive alias
          command nnn $argv

          if test -e $NNN_TMPFILE
              source $NNN_TMPFILE
              rm $NNN_TMPFILE
          end        
          '';
      };

      icat = "wezterm imgcat";
      ssh = "wezterm ssh";
      emacs = "emacsclient -t";

      N = "sudo n";

    }; 

    shellInit = ''
      set fish_key_bindings fish_user_key_bindings 
      zoxide init fish | source
      set EDITOR "emacsclient -t"
      ''; 
            
    shellAliases = {
      cd = "z";
    };
    
  };

  # Zoxide directory search
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}