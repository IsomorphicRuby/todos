class TodosView
  def list_elem
    $document['todos']
  end

  def add(todo)
    view = TodoView.new(todo)
    @todos << view
    list_elem.append view.render
  end

  def remove(todo)
    todo_view = @todos.delete_if! { |todo_view| todo_view.todo.id == todo.id }
    todo_view.remove
  end
end
