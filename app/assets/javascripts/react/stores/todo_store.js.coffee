class TodoStore
  @displayName: 'TodoStore'
	
  constructor: ->
    @bindActions(TodoActions)
    @todos = []

    @exportPublicMethods(
      {
        getTodos: @getTodos
      }
    )

    onInitData: (props)->
      @setState(props)

    getTodos: ()->
      @getState().todos

window.TodoStore = alt.createStore(TodoStore)
