paneLayoutFormatter = require './pane-layout-formatter'

module.exports =
  activate: ->
    atom.commands.add 'atom-workspace',
      'pane-layout:column-1': => @layout 1
      'pane-layout:column-2': => @layout 2
      'pane-layout:column-3': => @layout 3
      'pane-layout:column-4': => @layout 4
      'pane-layout:square': => @layout 5

  layout: (columns) ->
    paneLayoutFormatter.formatLayout columns
