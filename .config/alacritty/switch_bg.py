#!/usr/bin/python3

import os

path = os.path.join(os.getenv('HOME'), '.config/alacritty/alacritty.yml')
with open(path, 'r+') as f:
    cfg = f.read()
    if "    background: '#1a3a34'" in cfg:
        cfg = cfg.replace("    background: '#1a3a34'", "    background: '#f2f6e1'")
        cfg = cfg.replace("    foreground: '#f2f6e1'", "    foreground: '#1a3a34'")
    else:
        cfg = cfg.replace("    background: '#f2f6e1'", "    background: '#1a3a34'")
        cfg = cfg.replace("    foreground: '#1a3a34'", "    foreground: '#f2f6e1'")
    f.seek(0)
    f.write(cfg)
