class RestSync
  def initialize
    Todo.on(:create) { |todo| create(todo) unless todo.persisted? }
    Todo.on(:update) { |todo| update(todo) unless todo.persisted? }
  end

  def create(todo)
    Browser::HTTP.post '/todos', todo.to_json do
      on :success do |res|
      end
    end
  end

  def update(todo)
    Browser::HTTP.put "/todos/#{todo.id}", todo.to_json do
    end
  end
end
