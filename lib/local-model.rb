module LocalModel
  module ClassMethods
    def name
      self.class.to_s.downcase.pluralize
    end

    def models
      @models ||= []
    end

    def store
      @store ||= $global.localStorage
    end

    def save_all
      @storage.setItem name, klass.all.to_json
    end

    def all
      models = []

      if data = @storage.getItem()
        models = JSON.parse(data).map { |m| new(m) }
      end

      models
    end

    def find(id)
      model = nil

      if data = @storage.getItem(id)
        model = new(JSON.parse(data))
      end

      model
    end
  end

  def save
    self.class.save_all

    @storage.setItem id, to_json
    self
  end

  def update_attributes(attrs)
    attributes = attrs
    self.class.trigger(:update, self)
    save
  end

  def self.included(klass)
    klass.extend ClassMethods
  end
end
