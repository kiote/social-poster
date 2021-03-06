require 'vcr'

VCR.configure do |c|
  c.default_cassette_options = {record: :new_episodes}
  c.cassette_library_dir = 'features/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end
