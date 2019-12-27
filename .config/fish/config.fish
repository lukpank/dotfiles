# abbr -a e emacsclient -n

set -g fish_prompt_pwd_dir_length 0

bind \cg cancel

# to synch current directory betweeen Emacs an fish shell in vterm
function fish_vterm_prompt_end;
    printf '\e]51;A'(whoami)'@'(hostname)':'(pwd)'\e\\';
end
function track_directories --on-event fish_prompt; fish_vterm_prompt_end; end
