module EventsHelper
  include ActsAsTaggableOn::TagsHelper
  def display_location_info(city)
    ", #{city.name}, #{city.country.name}"
  end
end