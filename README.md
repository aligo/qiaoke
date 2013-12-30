Qiaoke
=========
Qiaoke is a slide-down Terminal Emulator for GTK Environment.

  - Multiple Tab
  - Monitor selection
  - Search terminal

Version
-
0.0.5

Build Requirements
-
 * valac >= 0.12.1
 * gcc or Clang/LLVM
 * intltool
 * pkg-config

Run Requirements
-
 * glib-2.0 >= 2.6
 * gtk+-2.0 >= 2.16
 * vte >= 0.28
 * unique-1.0

Installation
-
1. `./waf configure`
2. `./waf build`
3. `./build/qiaoke`

Default shortcuts
-
 * `F12` - Toggle the Qiaoke
 * `F11` - Toggle fullscreen
 * `Ctrl+Shift+q` - Quit the Qiaoke
 * `Ctrl+Shift+t` - New Tab
 * `Ctrl+Shift+w` - Close Tab
 * `F2` - Rename Tab
 * `Ctrl+k` - Reset Terminal
 * `Ctrl+Shift+c` - Copy
 * `Ctrl+Shift+v` - Paste
 * `Ctrl+Shift+f` - Find...
 * `Ctrl+Shift+h` - Find Next
 * `Ctrl+Shift+g` - Find Previous
 * `Ctrl+Shift+l` - Toggle Lock Tab (Hide close button)

Configure
-
in `~/.config/qiaoke/config.ini`

Author
-
aligo Kang <aligo_x@163.com>

License
-
Copyright (C) 2012-2014 aligo Kang <aligo_x@163.com>

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.