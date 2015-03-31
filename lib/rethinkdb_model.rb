module RethinkModel
  module ClassMethods
    def table
      @table ||= self.class.to_s.downcase.pluralize
    end

    def conn
      @conn ||= r.connect(:host    => ENV['RETHINKDB_HOST'] | 'localhost',
                         :port     => ENV['RETHINKDB_PORT'] |28015,
                         :db       => ENV['RETHINKDB_DB'] | 'test',
                         :auth_key => ENV['RETHINKDB_AUTH_KEY'])
    end

    def all
      models = []
      r.table(table).run(conn).each { |item| models << new(item) }
      models
    end

    def find
      m = r.table(table).get(id).run(conn)
      return nil unless m
      new(m)
    end

    def create(attrs)
      model =new(attrs).save
    end
  end

  def table
    self.class.table
  end

  def conn
    self.class.conn
  end

  def save
    if id
      r.table(table).get(id).update(attributes).run(conn)
    else
      res = r.table(table).insert(attributes).run(conn)
      id  = res[:generated_keys][0]
    end

    self
  end

  def update_attributes(attrs)
    attributes = attrs
    save
  end

  def self.included(klass)
    klass.extend ClassMethods
  end
end
