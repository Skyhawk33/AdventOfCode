import io
import sys
import time
# from aocd import get_data         # optional module to make inputting easier
from funge.main import main
from funge.platform import BufferedPlatform
from funge.semantics import Semantics

# -- Controls ---------------------------------------------------------

language = '-v98'           # commandline args for PyFunge

day = 1                     # the day to run the files for, and read input for with aocd (the aocd module is awesome)
# data = get_data(day=day, year=2023)

add_newline = True          # if true, a \n will be added to the end of the input data. required for some solutions
hit_breakpoint = False      # if true, debug printing will begin immediately
breakpoint_pos = (-1, 0)    # if the IP reaches this position, hit_breakpoint will be set to true
draw_debug = True           # if true, and the breackpoint has been hit, funge space will be drawn to stdout
step_time = 0.000           # the amount of time between steps after the breakpoint
max_frameskip = 0           # if > 0, draw_debug will only print every nth frame. useful for speeding up debug execution

draw_offset = (0, 0)        # the top-left-most cell to display in debug mode
draw_size = (120, 20)       # the width/height of the debug display


# -- Sample Data (comment out to use real data) -----------------------

data = u"""1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"""

if add_newline and data[-1] != '\n':
    data += '\n'
stream = io.StringIO(data)
stream.seek(0)


# -- Debug Step -------------------------------------------------------

frameskip = 0
bg_white = "\033[47m"
fg_black = "\033[30m"
reset = "\033[0m"


# Change Pycharm run configuration to emulate console for smoother output
def debug_command(self, ip):
    global hit_breakpoint, frameskip
    size = draw_size
    dx, dy = draw_offset
    x, y = ip.position
    if (x, y) == breakpoint_pos:
        hit_breakpoint = True
    if not hit_breakpoint:
        return base_command(self, ip)
    if draw_debug:
        if max_frameskip:
            frameskip = (frameskip + 1) % (max_frameskip + 1)
            if frameskip != max_frameskip:
                return base_command(self, ip)
        screen = ip.space.getspace((dx, dy), size, rtrim=False) + '\n'
        # drawspace = ip.space.getspace((400, 301), (10, 10), rtrim=False).replace('\00', 'X').replace(' ', '.') + '\n'
        if dx <= ip.position[0] < dx+size[0] and dy <= ip.position[1] < dy+size[1]:
            screen = screen[:(size[0]+1)*(y-dy)+(x-dx)]\
                     + bg_white + fg_black + screen[(size[0]+1)*(y-dy)+(x-dx)]\
                     + reset + screen[(size[0]+1)*(y-dy)+(x-dx)+1:]
        # out = '\033[2J' + '\n'
        out = ';' * (size[0] + 2) + '\n'
        out += ';' + screen.replace('\n', ';\n;') + ';' * (size[0] + 1) + '\n'
        # out += drawspace
        out += ''.join(map(str, ['pos ', ip.position, '  vel ', ip.delta, '  off ', ip.offset])) + '\n'
        for stack in reversed(ip.stack.sstack):
            out += str([str(i)+'('+chr(i)+')' if 32 <= i <= 126 else i for i in stack]) + '\n'
        print(out)
    # sys.stdout.flush()  # manual flush, useful if running in windows console
    # raw_input()  # manual step, useful if you're running this without IDE breakpoints
    time.sleep(step_time)  # PUT A BREAKPOINT HERE TO STEP
    return base_command(self, ip)  # KEEP A CONDITIONAL BREAKPOINT HERE ON "(x, y) in [(x1, y1), ...]" for large loops


# replace PyFunge functions so I can hook in the input data and the debug step
base_init = BufferedPlatform.__init__
BufferedPlatform.__init__ = lambda self, args, environ, stdin=stream, stdout=sys.stdout, warnings=False: \
    base_init(self, args, environ, stdin=stream, stdout=stdout, warnings=warnings)
base_command = Semantics.command
Semantics.command = debug_command


# -- Execution (comment out main lines to run single-parts) -----------

# main(['pyfunge', language, './_helloworld.b98'])

main(['pyfunge', language, './day%d_p1.b98' % day])
stream.seek(0)
main(['pyfunge', language, './day%d_p2.b98' % day])


# -- Notes ------------------------------------------------------------
# in Trefunge, use \f to separate planes
# in b93, inputting EOF just inputs 0. b98 reflects.
# TODO: look into https://github.com/cwesson/funge-plus-plus
