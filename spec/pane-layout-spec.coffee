{WorkspaceView} = require 'atom'

PaneLayout = require '../lib/pane-layout'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "PaneLayout:", ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspaceView.openSync()

  describe 'Columns:', ->
    it 'should set layout to 1 column', ->
      PaneLayout.layout 1

      expect(atom.workspaceView.getPanes().length).toBe 1

    it 'should set layout to 2 column', ->
      PaneLayout.layout 2

      expect(atom.workspaceView.getPanes().length).toBe 2

    it 'should set layout to 3 column', ->
      PaneLayout.layout 3

      expect(atom.workspaceView.getPanes().length).toBe 3

    it 'should set layout to 4 column', ->
      PaneLayout.layout 4

      expect(atom.workspaceView.getPanes().length).toBe 4

    it 'should set layout to square', ->
      PaneLayout.layout 5

      expect(atom.workspaceView.getPanes().length).toBe 4
