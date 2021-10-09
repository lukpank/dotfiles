import re
import subprocess
from collections import namedtuple

Monitor = namedtuple('Monitor', ["name", "width", "height"])

monitor_line = re.compile(r"^ *[0-9]+: +[+*]*([-A-Za-z0-9]+) +([0-9]+)/([0-9]+)x([0-9]+)/([0-9]+)\+([0-9]+)\+([0-9]+) +([-A-Za-z0-9]+)")

def list_monitors():
    p = subprocess.run(["xrandr", "--listmonitors"], capture_output=True, encoding='UTF-8')
    return [Monitor(name=m.group(1), width=int(m.group(2)), height=int(m.group(4)))
            for m in map(monitor_line.match, p.stdout.split('\n'))
            if m is not None]
