class GoogleAnalyticsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_config_file
    copy_file 'google_analytics.yml', Rails.root.join('config', 'google_analytics.yml')
  end
end
