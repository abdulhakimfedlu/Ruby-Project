class ApplicationController < ActionController::Base
  include VisitTracker
  helper_method :last_visit_time, :total_visits, :page_visits, :time_based_greeting
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
