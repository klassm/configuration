import subprocess
import sys
import re
import itertools
from enum import Enum


class DisplayType(Enum):
    INTERNAL = 1
    EXTERNAL_CONNECTED = 2
    EXTERNAL_DISCONNECTED = 3


def display_type_from(line):
    if "connected primary" in line:
        return DisplayType.INTERNAL
    elif " connected" in line:
        return DisplayType.EXTERNAL_CONNECTED
    elif "disconnected" in line:
        return DisplayType.EXTERNAL_DISCONNECTED
    else:
        raise Exception("cannot extract display type from '" + line + "'")


class Display:
    def __init__(self, name, type):
        self.name = name
        self.type = type
        self.resolutions = []

    def do_sort_resolutions(self):
        sorted_resolutions = sorted(map(lambda r: list(map(lambda p: int(p), list(r.split("x")))), self.resolutions), reverse=True)
        self.resolutions = list(map(lambda x: str(x[0]) + "x" + str(x[1]), list(sorted_resolutions)))

    def __repr__(self):
        return self.name + " (" + str(self.type) + ") resolutions=" + str(self.resolutions)


class DisplayConfiguration:
    def __init__(self):
        self._displays = self.find_display()

    def _display_from(self, line):
        type = display_type_from(line)
        name = line.split(" ")[0]
        return Display(name, type)

    def find_display(self):
        output = subprocess.check_output(["xrandr"]).decode('UTF-8').splitlines()
        displays = []
        display = None
        for line in output:
            if "connected" in line:
                display = self._display_from(line)
                displays.insert(0, display)
            resolution_match = re.search("[0-9]+x[0-9]+ ", line)
            if resolution_match:
                display.resolutions.insert(0, resolution_match.group(0).strip())

        for display in displays:
            display.do_sort_resolutions()

        return displays

    def displays_with_type(self, type):
        return list(filter(lambda d: d.type == type, self._displays))

    def _only_display_with_type(self, type):
        with_type = self.displays_with_type(type)
        if len(with_type) != 1:
            print ("cannot find only display with type '" + str(type) + "' in " + str(with_type))
            sys.exit(1)

        return with_type[0]

    def only_connected_external(self):
        return self._only_display_with_type(DisplayType.EXTERNAL_CONNECTED)

    def internal(self):
        return self._only_display_with_type(DisplayType.INTERNAL)

    def externals(self):
        return self.displays_with_type(DisplayType.EXTERNAL_DISCONNECTED) + \
               self.displays_with_type(DisplayType.EXTERNAL_CONNECTED)

    def connected(self):
        return self.displays_with_type(DisplayType.INTERNAL) + \
               self.displays_with_type(DisplayType.EXTERNAL_CONNECTED)


def modes():
    print(execute(["xrandr", "-q"]))


def intern(displays):
    off_command_for_external = map(lambda e: ['--output', e.name, '--off'], displays.externals())
    chained_off_command_for_externals = list(itertools.chain(*off_command_for_external))
    print(execute(
        ["xrandr", "--output", displays.internal().name, "--auto"] + chained_off_command_for_externals))


def extern(displays):
    print(execute(
        ["xrandr", "--output", displays.internal().name, "--off", "--output", displays.only_connected_external().name,
         "--auto"]))


def clone(displays):
    internal = displays.internal()
    connected = displays.connected()
    connected.remove(internal)
    clone_resolution = first_matching_resolution_in(connected + [internal])
    output_for_connected = list(map(lambda d: ["--output", d.name, "--mode", clone_resolution, "--same-as", internal.name],
                               connected))
    chained_output = list(itertools.chain(*output_for_connected))
    print(execute(
        ["xrandr", "--output", internal.name, "--mode", clone_resolution] + chained_output))


def extend_left(displays):
    print(execute(
        ["xrandr", "--output", displays.internal().name, "--auto", "--output", displays.only_connected_external().name,
         "--auto",
         "--left-of", displays.internal().name]))


def extend_right(displays):
    print(execute(
        ["xrandr", "--output", displays.internal().name, "--auto", "--output", displays.only_connected_external().name,
         "--auto",
         "--right-of", displays.internal().name]))


def first_matching_resolution_in(displaysToUse):
    if len(displaysToUse) == 1:
        return list(displaysToUse[0].resolutions)[0]
    first = displaysToUse[0]
    other = displaysToUse[1:]
    for res in first.resolutions:
        found = True
        for display in other:
            found = found and (res in display.resolutions)
        if found:
            return res
    raise Exception("cannot find common resolution in " + str(displaysToUse))

def recreatePolybar():
    subprocess.call(["/home/klassm/.config/polybar/launch"])

def execute(command):
    print(" ".join(command))
    return subprocess.check_output(command).decode('UTF-8')


if __name__ == '__main__':
    parameter = len(sys.argv) == 2 and sys.argv[1]
    displays = DisplayConfiguration()

    if parameter == 'modes':
        modes()
    elif parameter == 'intern':
        intern(displays)
    elif parameter == 'extern':
        extern(displays)
    elif parameter == 'clone':
        clone(displays)
    elif parameter == 'extend_left':
        extend_left(displays)
    elif parameter == 'extend_right':
        extend_right(displays)
    else:
        print ("""
    Usage:
    display <intern | extern | clone | extend_left | extend_right>
    
    Optionen:
    modes         Moegliche Modes ausgeben
    intern        Nur internen Bildschirm verwenden
    extern        Nur externer Bildschirm verwenden
    clone         Gleiche Ausgabe auf beiden Bildschirmen
    extend_left   Bild auf externem Bildschirm (links) erweitern
    extend_right  Bild auf externem Bildschirm (rechts) erweitern
    """)

