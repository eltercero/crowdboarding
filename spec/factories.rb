Factory.define :user do |user|
  user.sequence(:email) { |n| "info#{n}@onlinegeschenkenwinkel.nl" }
  user.password 'secret'
  user.name 'Crowdboarding'
  user.nickname 'crowdboarding'
end

Factory.define :event do |event|
  event.association :user
  event.association :country
  event.name "Retiro"
  event.starts_at Time.now + 2.weeks
  event.contact_details "1234567890"
  event.city_name "Madrid"
  event.address "Calle Alcala 177 7B"
  event.tag_tokens "Retiro Longboard"
end

Factory.define :country do |country|
  country.name "Spain"
  country.country_code "es"
end