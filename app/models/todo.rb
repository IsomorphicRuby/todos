require_relative '../../lib/local_model'
require_relative '../../lib/rethinkdb_model'
require 'virtus'

class Todo
  include RethinkModel unless defined?('$$')
  include LocalModel   if defined?('$$')
  include Virtus.model

  attribute :id,        String
  attribute :title,     String
  attribute :completed, Boolean

  def initialize(attrs = {})
    super(attrs)
    id = SecureRandom.uuid if defined?('$$')
  end
end
