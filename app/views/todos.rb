class TodosView
  def list_elem
    $document['#todo_list']
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

  def render(env = {})
    Paggio.html! do |_|
      _section.main! do
        _input.toggle_all! type: 'checkbox'
        _label for: 'toggle-all' do
          'Mark all as complete'
        end
        _ul.todo_list! do |list|
          env[:todos].each do |todo|
            view = TodoView.new(todo)
            @todos << view
            list << view
          end
        end
      end
    end
  end
end
