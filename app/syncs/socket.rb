class SocketSync
  def initialize
    Browser::Socket.new 'ws://todos' do
      on :message do |e|
        if todo = Todo.find(e.data.id)
          todo.update_attributes(e.data)
        else
          Todo.create(e.data)
        end
      end
    end
  end
end
