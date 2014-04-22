module.exports =
  ###
  @name Activate Item
  @description
  Activate a given item from a uri (Select the file that was previously selected).

  @param {String} uri
  ###

  activateItem: (uri) ->
    return unless uri?

    pane = atom.workspace.paneForUri uri

    pane.activate()

    pane.activateItemForUri uri

  ###
  @name Add Horizontal Panes
  @description
  For a given pane, add a number of panes after it.

  @params {Object} pane Pane to start from
  @params {Number} number_of_panes
  ###

  addHorizontalPanes: (pane, number_of_panes) ->
    i = 0

    while i < number_of_panes
      pane.splitRight()

      i++

  ###
  @name Add Wintdow Panes
  @description
  Add a window panes to the given workspace.

  @todo: pane.getNextPane() seems to be buggy
  ###

  addWindowPanes: ->
    open_panes = @getCurrentPanes()

    open_panes[0].splitRight()

    open_panes = @getCurrentPanes()

    open_panes[1].splitDown()

    open_panes[0].splitDown()

  ###
  @name Format Layout
  @description
  Format the pane layout based on the number of columns provided. Then select
  the pane item that was previously active.

  @params {Number} columns
  ###

  formatLayout: (columns) ->
    open_panes = @getCurrentPanes()

    number_of_panes = open_panes.length

    # if there are 4 panes we don't know the layout and must recalculate
    # otherwise skip if the layout is the same
    return if columns is number_of_panes and number_of_panes < 4

    # get current active pane
    active_item = atom.workspace.getActivePaneItem()

    # get current active item
    active_item_uri = active_item?.getUri()

    if columns in [4, 5]
      @removeEmptyPanes()

      @addWindowPanes() if columns is 5

      @addHorizontalPanes open_panes[0], 3 if columns is 4

      panes = @getCurrentPanes()

      for open_pane, i in open_panes
        continue if i is 0

        @movePane open_pane, panes[i]

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

    else if columns > number_of_panes
      number_of_new_panes = columns - number_of_panes

      last_pane = open_panes[open_panes.length - 1]

      @addHorizontalPanes last_pane, number_of_new_panes

    # set active item with previously active item
    @activateItem active_item_uri

  ###
  @name Get Current Panes
  @description
  Return the current panes of the workspace.

  @returns {Array} panes
  ###

  getCurrentPanes: ->
    panes = atom.workspaceView.getPanes()

    return (pane for pane in panes)

  ###
  @name Move Pane
  @description
  Move a panes items from one location to another.

  @params {Object} current_pane
  @params {Object} target_pane
  ###

  movePane: (current_pane, target_pane) ->
    items = current_pane.getItems()

    if items.length is 0
      current_pane.remove()

      return

    for item in items
      current_pane.moveItemToPane item, target_pane, target_pane.getItems().length

  ###
  @name Remove Empty Panes
  @description
  Remove an pane that does not contain any items.
  ###

  removeEmptyPanes: ->
    panes = atom.workspaceView.getPanes()

    for pane in panes
      pane.remove() if pane.getItems().length is 0
