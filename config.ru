require_relative 'app/views/layout'

class TodosChanges
  include Celluloid
  include Celluloid::Logger

  def initialize(app)
    @app = app
    async.publish_changes
  end

  def conn
    @conn ||= r.connect(:host    => ENV['RETHINKDB_HOST'] | 'localhost',
                       :port     => ENV['RETHINKDB_PORT'] |28015,
                       :db       => ENV['RETHINKDB_DB'] | 'test',
                       :auth_key => ENV['RETHINKDB_AUTH_KEY'])
  end

  def publish_changes
    info 'listening for changes on rethinkdb'
    r.table('todos').changes.run(conn).each { |todo|
      @app.websockets[:todos].each { |ws| ws.write message['new_val'].to_json }
    }
  end
end

class Todos
  websocket '/' do |ws|
    websockets[:todos] << ws
  end

  get '/' do
    @todos = todo.all
    Layoutview.new().render(todos: @todos)
  end

  put '/:id' do
    @todo = todo.find(params['id'])
    @todo.update_attributes(params['todo'])
    @todo.to_json
  end

  post '/' do
    @todo = todo.create(params['todo'])
    @todo.to_json
  end
end
