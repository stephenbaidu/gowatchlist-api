class ApplicationDecorator < Draper::Decorator
  delegate_all

  def url_host
    default_url_options['host']
  end

  def default_url_options
    @default_url_options ||= Rails.application.config_for(:default_url_options)
  end
end
