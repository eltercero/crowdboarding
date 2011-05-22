Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'vrScGb9FJH9tk57n9Xtag', 'lQCz1gyIKwtntRqgqOiEx4vJEcls5tWrN11kIvvj0'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
end