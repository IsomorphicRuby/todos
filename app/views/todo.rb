class TodoView
  on :dblclick, 'label' do
    element.add_class 'editing'
    input.focus
  end

  on :keypress, '.edit' do |e|
    finish_editing if e.which == 13
  end

  on :blur, '.edit' do
    finish_editing
  end

  on :click, '.destroy' do
    @todo.destroy
  end

  on :click, '.toggle' do
    @todo.update :completed => !@todo.completed
  end

  def initialize(todo)
    @todo = todo

    @todo.on(:update)  { update }
    @todo.on(:destroy) { destroy }
  end

  def title_elem
  end

  def update
    title_elem.text = @todo.title
  end

  def clear
    @todo.destroy
  end

  def finish_editing
    value = input.value.strip
    element.remove_class 'editing'
    value.empty? ? clear : @todo.update(title: value)
  end

  def render
  end
end
