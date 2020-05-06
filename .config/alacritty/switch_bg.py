#!/usr/bin/python3

import os

path = os.path.join(os.getenv('HOME'), '.config/alacritty/alacritty.yml')
with open(path, 'r+') as f:
    cfg = f.read()
    if "    background: '#424242'" in cfg:
        cfg = cfg.replace("    background: '#424242'", "    background: '#fafafa'")
        cfg = cfg.replace("    foreground: '#eeeeee'", "    foreground: '#424242'")
    else:
        cfg = cfg.replace("    background: '#fafafa'", "    background: '#424242'")
        cfg = cfg.replace("    foreground: '#424242'", "    foreground: '#eeeeee'")
    f.seek(0)
    f.write(cfg)
