describe Todo do
  before do
    Todo.destroy
    @todo_a = Todo.create(title: 'Foo', completed: true)
    @todo_b = Todo.create(title: 'Bar', completed: false)
    @todo_c = Todo.create(title: 'Baz', completed: true)
    @todo_d = Todo.create(title: 'Buz', completed: false)
  end

  describe '.new' do
    it 'returns a new instance of a todo' do
      expect(Todo.new(title: 'Todo')).to be_a Todo
    end
  end

  describe '.active' do
    it 'returns all non-completed todos' do
      expect(Todo.active).to eq([@todo_b, @todo_d])
    end
  end

  describe '.completed' do
    it 'returns all completed todos' do
      expect(Todo.completed).to eq([@todo_a, @todo_c])
    end
  end

  describe '#update_attributes!' do
    it 'updates attributes' do
      todo = Todo.create(title: 'Foo', completed: true)
      todo.update_attributes!(title: 'updated')
      todo = Todo.find todo.id
      expect(todo.title).to eq('updated')
    end
  end
end
