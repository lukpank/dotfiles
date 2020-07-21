#!/usr/bin/python3

import os
import sys

action = 'switch'
if len(sys.argv) > 1:
    action = sys.argv[1]
path = os.path.join(os.getenv('HOME'), '.config/alacritty/alacritty.yml')
with open(path, 'r+') as f:
    cfg = f.read()
    if "colors:  *dark" in cfg and action in ['switch', 'light']:
        cfg = cfg.replace("colors:  *dark", "colors: *light")
    elif "colors: *light" in cfg and action in ['switch', 'dark']:
        cfg = cfg.replace("colors: *light", "colors:  *dark")
    f.seek(0)
    f.write(cfg)
