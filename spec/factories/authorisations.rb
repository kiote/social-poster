# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorisation do
    user_id 1
    provider "MyString"
    uid "MyString"
  end
end
