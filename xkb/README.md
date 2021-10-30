# XKB layout

`/usr/share/X11/xkb`

[I read a good guide.](https://medium.com/@damko/a-simple-humble-but-comprehensive-guide-to-xkb-for-linux-6f1ad5e13450)

If you really want to mess with the low level stuff you use a combination of `xev -event keyboard` and edit the keymap directly in `/usr/share/X11/xkb/keycodes`.

Or you can just skip to making a keymap like in the example here.

This one is a workaround for my (otherwise wonderful) mechanical bluetooth keyboard. It has 'Up' and 'Slash' mapped to the same key. So I moved 'Up' to 'Left'. Lets see how it goes.

It also has 'Esc' ans 'Tilde' on the same key, I'll work on that next if this workaround goes smoothly.
