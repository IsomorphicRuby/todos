module BaseModel
  module ClassMethods
    def create(attrs)
      model = new(attrs).save
      self.class.trigger(:create, model)
      model
    end
  end
end
