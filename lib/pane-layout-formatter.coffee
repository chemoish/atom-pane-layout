module.exports =
  ###
  @name Activate Item
  @description
  Activate a given item from a uri (Select the file that was previously selected).

  @param {String} uri
  ###

  activateItem: (uri) ->
    return unless uri?

    pane = atom.workspace.paneForURI uri

    pane.activate()

    pane.activateItemForURI uri

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
  @name Add Window Panes
  @description
  Add a window panes to the given workspace.

  @todo: pane.getNextPane() seems to be buggy
  ###

  addWindowPanes: ->
    open_panes = @getCurrentPanes()

    open_panes[0].splitDown()

    open_panes[0].splitRight()

    open_panes = @getCurrentPanes()

    open_panes[2].splitRight()

  ###
  @name Focus Pane
  @description
  Update the currently focused pane.
  ###

  focusPane: (target_pane) ->
    atom.workspace.getPanes()[target_pane - 1]?.focus()

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

    # get current active item
    active_item_uri = atom.workspace.getActivePaneItem()?.getURI()

    # TODO: consider refactoring these methods
    if columns in [4, 5]
      new_pane_index = 3

      @removeEmptyPanes(open_panes)

      @addWindowPanes() if columns is 5

      @addHorizontalPanes open_panes[0], 3 if columns is 4

      @moveOverflowPanesToPaneIndex(open_panes, new_pane_index)

    else if number_of_panes > columns
      new_pane_index = columns - 1

      @removeEmptyPanes(open_panes)

      @addHorizontalPanes open_panes[0], new_pane_index

      @moveOverflowPanesToPaneIndex(open_panes, new_pane_index)

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
    return atom.workspace.getCenter().getPanes()

  ###
  @name Move Pane
  @description
  Move a panes items from one location to another.

  @params {Object} current_pane
  @params {Object} target_pane
  ###

  movePane: (current_pane, target_pane) ->
    items = current_pane.getItems()

    return if items.length is 0

    for item in items
      current_pane.moveItemToPane item, target_pane

    current_pane.destroy();

  moveOverflowPanesToPaneIndex: (open_panes, pane_index) ->
    panes = @getCurrentPanes()

    for open_pane, i in open_panes
      # always skip first pane cause it is immutable
      continue if i is 0

      if (i <= pane_index)
        @movePane open_pane, panes[i]
      else
        @movePane open_pane, panes[pane_index]

  ###
  @name Remove Empty Panes
  @description
  Remove an pane that does not contain any items.
  ###

  removeEmptyPanes: (panes) ->
    for pane, i in panes
      continue if i is 0

      pane.destroy() if pane.getItems().length is 0
