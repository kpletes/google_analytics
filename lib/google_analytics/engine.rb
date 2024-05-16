module GoogleAnalytics
  class Engine < ::Rails::Engine
    require root.join('app', 'helpers', 'application_helper.rb')

    initializer 'google_analytics.load_settings' do
      begin
        GoogleAnalytics::SETTINGS = YAML.load(ERB.new(File.read(Rails.root.join('config', 'google_analytics.yml'))).result, aliases: true)[Rails.env]
      rescue Exception
        Rails.logger.warn('Google Analytics configuration file not found (config/google_analytics.yml):')
      end
    end

    initializer 'google_analytics.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper GoogleAnalytics::ApplicationHelper
      end
    end

    require root.join('lib', 'controller_module.rb')
    initializer 'google_analytics.application_controller' do
      ActiveSupport.on_load :action_controller do
        include GoogleAnalytics::Controller
      end
    end
  end
end
