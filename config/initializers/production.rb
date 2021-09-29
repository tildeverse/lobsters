class << Rails.application
  def domain
    "tilde.news"
  end

  def name
    "tilde news"
  end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
