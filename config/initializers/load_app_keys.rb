
require 'yaml'
APP_KEYS = YAML::load(File.open('%s/app_keys.yml' % Rails.root.join('config')))
