
require 'yaml'

APP_KEYS = YAML::load(File.open('%s/app_keys.yml' % Rails.root.join('config')))

MISC_PARAMS = YAML::load(File.open('%s/misc_params.yml' % Rails.root.join('config')))
