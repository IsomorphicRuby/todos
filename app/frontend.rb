class Frontend
  get '/' do
    @todos = Todo.all
    Layoutview.new().render(todos: @todos)
  end
end
