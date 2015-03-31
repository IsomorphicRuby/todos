require_relative 'main'
class LayoutView
  def initialize
    @app_view = AppView.new
  end

  def render(env = {})
    Paggio.html do |_|
      _.head do
        _.meta charset: 'utf-8'
        _.meta 'http-equiv' => 'X-UA-Compatible', :content => 'IE=edge,chrome=1'

        _.link rel: 'stylesheet', href: '/assets/app.css'
      end

      _.body do
        @app_view.render(env)
      end
    end
  end
end
