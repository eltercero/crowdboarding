module ApplicationHelper
  def selected?(path)
    'selected' if request.fullpath == path
  end
  
  def events_selected?
    "selected" if (controller_name == "events" || (controller_name == "home" && action_name== "index"))
  end
  
  def riders_selected?
    "selected" if controller_name == "riders"
  end
  
  def show_splash?
    current_page? root_path and !user_signed_in?
  end
  
  def relative_date(date)
    event_time = date.to_time.in_time_zone
    today = Time.now.in_time_zone
    if event_time < today || (today+6.days) < event_time#left
      return l(date, :format => :event)
    else #ago
      if today.wday == event_time.wday
        "Today, "+event_time.strftime("%H:%M")
      else
        "Next "+event_time.strftime("%A, %H:%M")
      end
    end
  end
  
  def distance_of_time_in_short_words(starts_at)
    ago_or_left = starts_at > Time.now ? "left" : "ago"
    distance_in_seconds = ((Time.now - starts_at).abs).round
    distance_in_minutes = distance_in_seconds / 60
    distance_in_hours = distance_in_minutes / 60
    distance_in_days = distance_in_hours / 24
    
    case distance_in_days
    when 0..1
      case distance_in_hours
      when 0..1
        case distance_in_minutes
        when 0..1 then content_tag(:span,distance_in_seconds) + " seconds #{ago_or_left}"
        when 1..59 then content_tag(:span, distance_in_minutes) + " minutes #{ago_or_left}"
        end
      when 1..24
        content_tag(:span, distance_in_hours) + " hours #{ago_or_left}"
      end
    else
      content_tag(:span, distance_in_days) + " days #{ago_or_left}"
    end
  end
  
  # Generate the title of the page
  def get_title
    title = []
    # Exceptions
    prefix_title = if controller_name == "events" && action_name == "show" && @event.present?
      t('titles.events.show', :name => @event.name, :city => @event.city_name)
    elsif controller_name == "users" && action_name == "show" && @user.present?
      t('titles.users.show', :name => @user.print_name)
    end
    if prefix_title.blank? || prefix_title.match(/translation_missing/)
      # Just translate the controller and action if it exists in the language file
      prefix_title = t("titles.#{controller_name}.#{action_name}")
      prefix_title = (prefix_title.match(/translation_missing/)) ? nil : prefix_title
    end
    # If add the prefix and suffix in title if there isnt a translation missing
    if prefix_title.present? && !prefix_title.match(/translation_missing/)
      title << prefix_title
      title << t('titles.suffix')
    else
      # Use the default title
      title << t('titles.default_title')
    end
    # We put the controller name and action name in the title if we are in development. Just handy.
    if RAILS_ENV == "development"
      title << "#{controller_name}##{action_name}"
    end
    # Generate the title
    strip_tags(title.join(" - "))
  end
  
  def get_keywords
    "crowdboarding, longboard, skateboard, madrid, events, slide, downhill"
  end
  
  def get_description
    "Crowdboarding.com is an online Longboard community."
  end
end