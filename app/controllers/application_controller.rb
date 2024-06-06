class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :render_liquid_template

  def render_liquid_template(data, template_path)
    template = Liquid::Template.parse(File.read(Rails.root.join('app', 'views', template_path)))
    render html: template.render(data).html_safe
  end
end
