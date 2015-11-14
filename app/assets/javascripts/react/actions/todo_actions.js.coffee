class TodoActions
  constructor: ->
    @generateActions(
      'initData'
    )

window.TodoActions = alt.createActions(TodoActions)