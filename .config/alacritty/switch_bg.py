#!/usr/bin/python3

import os

path = os.path.join(os.getenv('HOME'), '.config/alacritty/alacritty.yml')
with open(path, 'r+') as f:
    cfg = f.read()
    if "colors:  *dark" in cfg:
        cfg = cfg.replace("colors:  *dark", "colors: *light")
    else:
        cfg = cfg.replace("colors: *light", "colors:  *dark")
    f.seek(0)
    f.write(cfg)
