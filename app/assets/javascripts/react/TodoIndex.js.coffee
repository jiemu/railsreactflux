{ div, h1, ul, li, a, span, label, input } = React.DOM

TodoForm = React.createFactory React.createClass
  getInitialState: ->
    todoName: ''

  onInputChange: (e) ->
    @setState(todoName: e.target.value)

  onInputKeyDown: (e) ->
    if e.keyCode == 13 && this.refs.todo.value.length
      @props.submitTodo(this.refs.todo.value)
      @setState(todoName: '')

  render: ->
    div className: 'form-group',
      label {}, 'Enter Todo'
      input
        onChange: @onInputChange,
        onKeyDown: @onInputKeyDown,
        ref: 'todo',
        className: 'form-control',
        placeholder: 'Enter todo name'
        value: @state.todoName

TodoListItem = React.createFactory React.createClass
  render: ->
    li className: 'list-item', 
      a className: 'btn btn-primary', 'Check'
      span className: 'list-text', @props.todo.name


TodoList = React.createFactory React.createClass
  render: ->
    ul className: 'list-unstyled',
      _.map @props.todos, (todo)=>
        TodoListItem(todo: todo)

window.TodoIndex = React.createClass
  getInitialState: ->
  	todos: []

  componentWillMount: ->
  	@setState(todos: @props.todos)

  submitTodo: (name) ->
    $.ajax
      type: 'POST'
      url: '/todos'
      data:
        todo:
          name: name
          checked: false
      success: (response) =>
        @state.todos.push(response)
        @setState(todos: @state.todos)
        console.log(response)
      error: (response) =>
        console.log('error')
        console.log(response)

  render: ->
    div className: 'container',
      div className: 'row',
        div className: 'col-xs-12',
          h1 {}, 'Todo List'
          TodoForm(submitTodo: @submitTodo)
          TodoList(todo: @state.todos)
          ul className: 'list-unstyled',
            _.map @state.todos, (todo)=>
              li className: 'list-item', 
                a className: 'btn btn-primary', 'Check'
                span className: 'list-text', todo.name

