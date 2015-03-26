class MainView
  def todos
  end

  def initialize
  end

  def render(env = {})
    Paggio.html! do
      section.main! do
        input.toggle_all! type: 'checkbox'
        label for: 'toggle-all' do
          'Mark all as complete'
        end
        ul.todo_list!
      end
    end
  end
end
