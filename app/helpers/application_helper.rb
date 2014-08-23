module ApplicationHelper
  def format_datetime(dt)
  	if logged_in? && !current_user.time_zone.blank?
			dt = dt.in_time_zone(current_user.time_zone) 
		end
    dt.strftime("%m/%d/%Y %H:%m%p %Z")
  end

  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end
end
