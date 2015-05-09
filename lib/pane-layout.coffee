paneLayoutFormatter = require './pane-layout-formatter'

module.exports =
  activate: ->
    atom.commands.add 'atom-workspace',
      'pane-layout:column-1': => @layout 1
      'pane-layout:column-2': => @layout 2
      'pane-layout:column-3': => @layout 3
      'pane-layout:column-4': => @layout 4
      'pane-layout:square': => @layout 5

      'pane-layout-focus:column-1': => @focus 1
      'pane-layout-focus:column-2': => @focus 2
      'pane-layout-focus:column-3': => @focus 3
      'pane-layout-focus:column-4': => @focus 4

  focus: (column) ->
    paneLayoutFormatter.focusPane column

  layout: (columns) ->
    paneLayoutFormatter.formatLayout columns
