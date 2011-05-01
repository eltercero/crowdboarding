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
end