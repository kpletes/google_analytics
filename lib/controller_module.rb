module GoogleAnalytics
  module Controller
    extend ActiveSupport::Concern

    def ga_campaign_params(medium, alternative_source = nil, options = {})
      { :utm_campaign => GoogleAnalytics::SETTINGS['ga_campaign_name'],
        :utm_source => (alternative_source || GoogleAnalytics::SETTINGS['ga_campaign_source']),
        :utm_medium => (medium || 'unspecified') }.merge options
    end

    def add_utm_params
      if params[:utm_campaign].blank? and params[:utm_source].blank? and params[:utm_medium].blank?
        medium = nil
        source = nil

        if params[:type] == 'discovery'
          medium = 'discovery'
          source = 'Viral'
        end
        if params[:ref] == 'bookmarks'
          medium = 'bookmarks'
          source = 'Facebook feature'
        end
        if params[:fb_source] == 'other_multiline'
          medium = 'multiline'
          source = 'Viral'
        end
        if params[:ref] == 'games_ego'
          medium = 'app_sidebar'
          source = 'Viral'
        end
        if params[:fb_source] == 'aggregation'
          medium = 'profile_aggregation'
          source = 'Viral'
        end
        if params[:ref] == 'games_featured'
          medium = 'games_dashboard_featured'
          source = 'Facebook feature'
        end
        if params[:fb_source] == 'dashboard_toplist'
          medium = 'games_dashboard_toplist'
          source = 'Facebook feature'
        end
        if params[:fb_source] == 'dashboard_suggestion'
          medium = 'games_dashboard_suggestion'
          source = 'Facebook feature'
        end
        if params[:fb_source] == 'feed_using'
          medium = 'started_playing_feed'
          source = 'Viral'
        end
        if params[:fb_source] == 'feed_playing'
          medium = 'playing_feed_short'
          source = 'Viral'
        end
        if params[:fb_source] == 'feed'
          medium = 'playing_feed'
          source = 'Viral'
        end
        if params[:fb_source] == 'feed_aggregated'
          medium = 'playing_feed_aggregated'
          source = 'Viral'
        end

        redirect_to url_for({ :controller => controller_name, :action => action_name }.merge ga_campaign_params(medium, source, params)) if (medium and source)
      end
    end
  end
end