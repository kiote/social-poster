# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :authorisation do
    provider "twitter"
    uid "3141597"
    token "tk13"
    secret "sc13"
  end
  
end
