# This configuration file works with both the Compass command line tool and within Rails.
# Require any additional compass plugins here.
project_type = :rails
project_path = Compass::AppIntegration::Rails.root
environment  = Compass::AppIntegration::Rails.env

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = Compass::AppIntegration::Rails.env == :production ? 'tmp/stylesheets' : 'public/stylesheets'
sass_dir = "app/stylesheets"
environment = Compass::AppIntegration::Rails.env
# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true
preferred_syntax = :sass
require 'ninesixty'