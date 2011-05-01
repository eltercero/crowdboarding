module ApplicationHelper
  def selected?(path)
    'selected' if request.fullpath == path
  end
  
  def events_selected?
    "selected" if (controller_name == "events" || (controller_name == "home" && action_name== "index"))
  end
end