# Atom.io – Pane Layout Package

Focus and control the layout of your atom editor.

## Features

| Command | Mac | PC and Linux |
| --- | --- | --- |
| Set the column layout | Cmd + Alt + [1-5] | Alt + Shift + [1-5] |
| Jump to column | Ctrl + [1-4] | Same |

## Demo

![pane-layout](https://raw.github.com/chemoish/atom-pane-layout/master/demo.gif)

## Nitty Gritty

 - When a layout is chosen that increases the pane count, any additional panes will be left empty.
 - When a layout is chosen that decreases the pane count, any left over panes will be collapsed into the last available pane.
 - When a layout is chosen and a custom layout is already in place, any left over panes will be collapsed into the last available pane.
 - When a layout is changed that causes panes to collapse, stay focused on the active file – iff the file is in the file system.
