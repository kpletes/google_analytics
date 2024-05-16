$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "google_analytics/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "google_analytics"
  s.version     = GoogleAnalytics::VERSION
  s.authors     = ["Ivan Rukavina"]
  s.email       = ["ivan.rukavina@drap.hr"]
  s.homepage    = "https://bitbucket.org/drap/google_analytics"
  s.summary     = "Gem for integrating your Rails/FB application with Google Analytics."
  s.description = "This gem offers easy Google Analytics integration with several standard helpers like Google Analytics event generation and utm parameter URL addition."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 6"
  s.add_dependency "sprockets", "~> 3"
  s.add_dependency "mail", "< 2.8"
  s.add_dependency "net-smtp"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3", "~> 1.4"
end
