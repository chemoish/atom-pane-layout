module.exports =
  addHorizontalPanes: (pane, number_of_panes) ->
    return unless pane?

    i = 0

    while i < number_of_panes
      pane.splitRight()

      i++

  addWindowPanes: (pane) ->
    if pane?
      pane.splitRight()
      pane.getNextPane().splitDown()
      pane.splitDown()

  formatLayout: (columns) ->
    panes = atom.workspaceView.getPanes()
    number_of_panes = panes.length

    return if columns is number_of_panes and number_of_panes < 4

    # 4 panes -> 3 panes
    if number_of_panes > columns
      newPaneIndex = columns - 1

      panes = atom.workspaceView.getPanes()

      for pane in panes
        pane.remove() if pane.getItems().length is 0

      panes = atom.workspaceView.getPanes()

      _panes = []
      _panes.push panes[0] if panes[0]?
      _panes.push panes[1] if panes[1]?
      _panes.push panes[2] if panes[2]?
      _panes.push panes[3] if panes[3]?

      @addHorizontalPanes panes[0], newPaneIndex

      panes = atom.workspaceView.getPanes()

      return if _panes.length <= newPaneIndex

      i = 1

      while i <= _panes.length - 1
        if i <= newPaneIndex
          @movePane _panes[i], panes[i]
        else
          @movePane _panes[i], panes[newPaneIndex]

        i += 1

    else if columns is 4
      pane1 = atom.workspaceView.getPanes()[0]
      pane2 = panes[1]
      pane3 = panes[2]
      pane4 = panes[3]

      @addHorizontalPanes pane1, 3

      panes = atom.workspaceView.getPanes()

      @movePane pane2, panes[1] if pane2?
      @movePane pane3, panes[2] if pane3?
      @movePane pane4, panes[3] if pane4?

    # 2 panes -> "5" panes
    else if columns is 5
      pane1 = atom.workspaceView.getPanes()[0]
      pane2 = panes[1]
      pane3 = panes[2]
      pane4 = panes[3]

      @addWindowPanes pane1

      panes = atom.workspaceView.getPanes()

      @movePane pane2, panes[1] if pane2?
      @movePane pane3, panes[2] if pane3?
      @movePane pane4, panes[3] if pane4?

    # 2 panes -> 4 panes
    else
      last_pane           = panes[number_of_panes - 1]
      number_of_new_panes = columns - number_of_panes

      @addHorizontalPanes last_pane, number_of_new_panes

  movePane: (current_pane, target_pane) ->
    items = current_pane.getItems()

    if items.length is 0
      current_pane.remove()

      return

    for item in items
      current_pane.moveItemToPane item, target_pane, target_pane.getItems().length

  removePane: (pane) ->
    if pane?
      pane.remove()
