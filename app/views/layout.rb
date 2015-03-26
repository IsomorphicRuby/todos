require 'paggio'
require_relative 'main'
class LayoutView
  def initialize
    @main_view = MainView.new()

    Todo.on(:create)  { |todo| @todos_view.add(todo) }
    Todo.on(:destroy) { |todo| @todos_view.remove(todo) }

    setup_events
  end

  on :keypress, '#new_todo' do |e|
    value = @input.value.strip
    if e.which == 13 and !value.empty?
      Todo.create title: value, completed: false
      @input.value = ''
    end
  end

  on :click, '#toggle-all' do
    Todo.all.each { |t| t.update_attributes(completed: !t.completed) }
  end

  on :click, '#clear-completed' do
    Todo.completed.each { |t| t.destroy }
  end

  def render(env = {})
    Paggio.html do |_|
      _.head do
        _.meta charset: 'utf-8'
        _.meta 'http-equiv' => 'X-UA-Compatible', :content => 'IE=edge,chrome=1'

        _.link rel: 'stylesheet', href: '/assets/app.css'
      end

      _.body do
        _.section.todoapp! do
          _.header.header! do
            _.h1 'Todos'
            _.input.new_todo! placeholder: 'What needs to be done?', autofocus: true
          end

          _.div { @main_view.render(env) }
          _.footer.footer!
        end

        _.div.info! do
          _.p 'Double-click to edit a todo'
          _.p do
            _.span 'Part of'
            _.a href: 'http://todomvc.com' 'TodoMVC'
          end
        end
      end
    end
  end
end
