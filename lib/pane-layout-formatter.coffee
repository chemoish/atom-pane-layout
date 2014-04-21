module.exports =
  activateItem: (uri) ->
    pane = atom.workspace.paneForUri uri

    pane.activate()

    pane.activateItemForUri uri

  addHorizontalPanes: (pane, number_of_panes) ->
    pane.splitRight() for [0..number_of_panes - 1]

  # TODO: pane.getNextPane() seems to be buggy
  addWindowPanes: ->
    open_panes = @getCurrentPanes()

    open_panes[0].splitRight()

    open_panes = @getCurrentPanes()

    open_panes[1].splitDown()

    open_panes[0].splitDown()

  formatLayout: (columns) ->
    open_panes = @getCurrentPanes()

    number_of_panes = open_panes.length

    # if there are 4 panes we don't know the layout and must recalculate
    # otherwise skip if the layout is the same
    return if columns is number_of_panes and number_of_panes < 4

    # get current active pane
    active_pane = atom.workspace.getActivePaneItem()

    # get current active item
    active_pane_uri = active_pane.getUri()

    if columns in [4, 5]
      @removeEmptyPanes()

      @addWindowPanes() if columns is 5

      @addHorizontalPanes open_panes[0], 3 if columns is 4

      panes = @getCurrentPanes()

      for open_pane, i in open_panes
        continue if i is 0

        @movePane open_pane, panes[i]

    # 4 panes -> 3 panes
    else if number_of_panes > columns
      new_pane_index = columns - 1

      @removeEmptyPanes()

      @addHorizontalPanes open_panes[0], new_pane_index

      panes = atom.workspaceView.getPanes()

      for open_pane, i in open_panes
        continue if i is 0

        if i <= new_pane_index
          @movePane open_pane, panes[i]
        else
          @movePane open_pane, panes[new_pane_index]

    # 2 panes -> 4 panes
    else if columns > number_of_panes
      number_of_new_panes = columns - number_of_panes

      last_pane = open_panes[open_panes.length - 1]

      @addHorizontalPanes last_pane, number_of_new_panes

    # set active item with previously active item
    @activateItem active_pane_uri

  getCurrentPanes: ->
    panes = atom.workspaceView.getPanes()

    return (pane for pane in panes)

  movePane: (current_pane, target_pane) ->
    items = current_pane.getItems()

    if items.length is 0
      current_pane.remove()

      return

    for item in items
      current_pane.moveItemToPane item, target_pane, target_pane.getItems().length

  removeEmptyPanes: ->
    panes = atom.workspaceView.getPanes()

    for pane in panes
      pane.remove() if pane.getItems().length is 0
