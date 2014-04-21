paneLayoutFormatter = require './pane-layout-formatter'

module.exports =
  activate: ->
    atom.workspaceView.command 'pane-layout:toggle-1', => @layout 1
    atom.workspaceView.command 'pane-layout:toggle-2', => @layout 2
    atom.workspaceView.command 'pane-layout:toggle-3', => @layout 3
    atom.workspaceView.command 'pane-layout:toggle-4', => @layout 4
    atom.workspaceView.command 'pane-layout:toggle-5', => @layout 5

  layout: (columns) ->
    paneLayoutFormatter.formatLayout columns
