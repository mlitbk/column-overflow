ColumnOverflowView = require './column-overflow-view'

views = []
active = false

module.exports =
  configDefaults:
    column: 80

  activate: (state) ->
    atom.workspaceView.command 'column-overflow:toggle', => @toggle()

  destroyViews: ->
    while view = views.shift()
      view.destroy()

  deactivate: ->
    @destroyViews()

  updateViews: ->
    atom.workspaceView.eachEditorView (editorView) ->
      if editorView.attached and editorView.getPane()
        view = new ColumnOverflowView(editorView)
        views.push(view)
        editorView.underlayer.append(view)

  toggle: ->
    active = not active
    if active
      @updateViews()
    else
      @destroyViews()
