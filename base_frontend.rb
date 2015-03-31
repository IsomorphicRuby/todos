class BaseFrontend
  def self.router
    @router ||= Vienna::Router.new
  end

  def self.route(*args)
    router.
  end
end
