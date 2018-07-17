class << Rails.application
  def domain
    "links.tildeverse.org"
  end

  def name
    "tilde news"
  end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain