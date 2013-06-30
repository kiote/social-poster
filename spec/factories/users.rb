# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
  end
end
