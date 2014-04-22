paneLayoutFormatter = require './pane-layout-formatter'

module.exports =
  activate: ->
    atom.workspaceView.command 'pane-layout:column-1', => @layout 1
    atom.workspaceView.command 'pane-layout:column-2', => @layout 2
    atom.workspaceView.command 'pane-layout:column-3', => @layout 3
    atom.workspaceView.command 'pane-layout:column-4', => @layout 4
    atom.workspaceView.command 'pane-layout:square', => @layout 5

  layout: (columns) ->
    paneLayoutFormatter.formatLayout columns
