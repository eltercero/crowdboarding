module EventsHelper
  include ActsAsTaggableOn::TagsHelper
  def display_location_info(event)
    ", #{event.city_name}, #{event.country.name}"
  end
end