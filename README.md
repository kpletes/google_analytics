# Google Analytics
Gem for integrating Google Analytics service with your Rails 3.2.x application.
## Installation
If you haven't already, add the DRAP's gem repository to your `Gemfile`:
```ruby
  source 'http://*****:*****@gems.drap.me/'
```

Afterwards add `google_analytics` to your `Gemfile`:

```ruby
  gem 'google_analytics', '~> 0.2.0'
```

Download and install by running:

```
bundle install
```

Initialize the `google_analytics.yml` configuration YAML file with:

```
rails generate google_analytics
```


## Usage
Add the following snippet to your layouts (ie.: `layouts/application.html.erb`) to render the Google Analytics script:
```ruby
<%= render_google_analytics_script %>
```

Add the following snippet to your layouts (ie.: `layouts/application.html.erb`) to render the Google Tags script:
```ruby
<%= render_google_tags_script, debug: false %>
```

If you want to add utm parameters to your URLs add the following command to your `application_controller.rb`:
```ruby
before_filter :add_utm_params
```

When you need to trigger an event you can render the relevant JavaScript command by calling the ga_js_event helper:
```ruby
  <%= ga_js_event(category,action,label,value, try_catch = true) %>
```