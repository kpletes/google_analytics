class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_utm_params
end
