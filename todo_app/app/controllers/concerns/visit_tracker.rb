module VisitTracker
  extend ActiveSupport::Concern

  included do
    before_action :track_visit
  end

  private

  def track_visit
    session[:last_visit] = Time.current
    session[:visit_count] ||= 0
    session[:visit_count] += 1
    
    # Track page-specific visits
    page = request.path
    session[:page_visits] ||= {}
    session[:page_visits][page] ||= 0
    session[:page_visits][page] += 1
  end

  def last_visit_time
    return "First visit!" unless session[:last_visit]
    
    time_diff = Time.current - session[:last_visit]
    if time_diff < 60
      "#{time_diff.to_i} seconds ago"
    elsif time_diff < 3600
      "#{(time_diff / 60).to_i} minutes ago"
    else
      "#{(time_diff / 3600).to_i} hours ago"
    end
  end

  def total_visits
    session[:visit_count] || 0
  end

  def page_visits
    session[:page_visits]&.fetch(request.path, 0) || 0
  end

  def time_based_greeting
    current_hour = Time.current.hour
    
    case current_hour
    when 5..11
      "Good morning!"
    when 12..16
      "Good afternoon!"
    when 17..20
      "Good evening!"
    else
      "Good night!"
    end
  end
end 