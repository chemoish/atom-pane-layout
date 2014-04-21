# pane-layout package

A short description of your package.

![A screenshot of your spankin' package](https://f.cloud.github.com/assets/69169/2290250/c35d867a-a017-11e3-86be-cd7c5bf3ff9b.gif)

# adding panes
2 -> 4 (filled)

- ? remove empty panes (extra step)
- get last pane
- 4 - 2
- add 2 pane
- [x][x][][]

2 -> 4 (unfilled)

- ? remove empty panes (extra step)
- get last pane
- 4 - 2
- add 2 pane
- [x][][][]

# changing layout
4 -> 5 (filled)

- ? remove empty panes
- save all open panes
- create new window layout (1 +)
- for each saved panes
  - remove if empty (skip if done above)
  - move saved pane to open slot

4 -> 5 (unfilled)

- ? remove empty panes
- save all open panes
- create new window layout (1 +)
- for each saved panes
  - remove if empty (skip if done above)

5 -> 4 (filled)

- ? remove empty panes
- save all open panes
- create new horizontal layout (1 +)
- for each saved panes
  - remove if empty (skip if done above)
  - move saved pane to open slot

5 -> 4 (unfilled)

# removing panes
4 -> 2 (filled)

- 4 - 2 (get last pane index)
- ? remove empty panes (would save in iterations)
- save all open panes
- create new horizontal layout (1 +)
- for each saved panes
  - remove if empty (skip if done above)
  - move saved panes to open pane
  - move saved panes to last pane

4 -> 2 (unfilled)

- ? remove empty panes
