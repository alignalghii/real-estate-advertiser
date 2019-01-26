#!/bin/sed -f

/class="timer".*interval="15"/s!\([^']*\)\('\?localhost[^ ]*\)\(\s*\).*!&\n\1\2\3| grep -q '<script src="timer.js"></script>' \&\& test -f timer.js; then echo ' + OK   : JS   loadable for 15s-timer'; let nOK++; else echo ' - Wrong: JS unloadable for 15s-timer'; fi; let nAll++;!;
