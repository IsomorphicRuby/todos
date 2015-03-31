require 'opal'
require 'opal/vienna'

todos_view.initialize

class Frontend < BaseFrontend
  route '/append-todo/:id' do
    todo = Todo.find params[:id]
    todos_view.add <<
  end
end

$document.ready
