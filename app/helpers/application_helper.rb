module GoogleAnalytics
  module ApplicationHelper
    def render_google_analytics_script options = {}
      return unless GoogleAnalytics::SETTINGS['ga_id']
      return if GoogleAnalytics::SETTINGS['ga_id'].match?(/^XX/)

      tracking = []
      tracking << "ga('require', 'displayfeatures');" if options[:remarketing]
      tracking << "ga('require', 'ecommerce');" if options[:ecommerce]
      tracking << "ga('set', 'anonymizeIp', true);" if options[:anonymizeIP].nil? || options[:anonymizeIP]
      if defined?(Turbolinks) == 'constant'
        tracking << "document.addEventListener('turbolinks:load', function () {"
        tracking << "  ga('set', 'location', location.href.split('#')[0]);"
        tracking << "  ga('send', 'pageview');"
        tracking << "});"
      else
        tracking << "ga('send', 'pageview');"
      end

      raw <<-script
        <script>
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

          ga('create', '#{GoogleAnalytics::SETTINGS['ga_id']}', '#{GoogleAnalytics::SETTINGS['ga_domain']}');
          #{ tracking.join("\n          ").html_safe }
        </script>
script

    end

    def render_google_tags_script options = {}
      options[:debug] = false if options[:debug].nil?
      return unless GoogleAnalytics::SETTINGS['ga_id']

      raw <<-script
          <!-- Google tag (gtag.js) -->
          <script src="https://www.googletagmanager.com/gtag/js?id=#{GoogleAnalytics::SETTINGS['ga_id']}" data-turbo-track="reload" async></script>
          <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', "#{GoogleAnalytics::SETTINGS['ga_id']}", { 'debug_mode':#{options[:debug]} });
          </script>
          <script>
          document.addEventListener('turbolinks:load', function(event) {
            var url = event.data.url;
            alert(url);
            alert(location.href.replace(location.origin, ""));
            gtag('event', 'page_view', {
              page_title: document.title,
              page_location: url,
              page_path: location.href.replace(location.origin, ""),
              send_to: '#{GoogleAnalytics::SETTINGS['ga_id']}',
              'debug_mode':#{options[:debug]}
            })
          })
          </script>
script
    end

    def ga_js_event(category, action, label, value, try_catch = true)
      # tracking = "ga('send', 'event', '#{category.to_s}', '#{action.to_s}', '#{label.to_s}', '#{value.to_s}');"
      tracking = "gtag('event', '#{action.to_s}', { 'category': '#{category.to_s}', 'label': '#{label.to_s}', 'value': '#{value.to_s}' });"
      if try_catch
        return "try { #{tracking} } catch(err) {};"
      else
        return tracking
      end
    end
  end
end
