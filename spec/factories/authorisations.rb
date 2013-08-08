# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :authorisation do
    provider "twitter"
    uid "3141597"
    token "tk13"
    secret "sc13"
  end
  
  factory :auth_linkedin, class: Authorisation do
    provider "linkedin"
    uid "EsKOV6HBMr"
    token "2d19df97-5c12-4ed0-80b0-5879109bf6ec"
    secret "b1dc687d-2a64-42e2-8300-fa3b161f0630"
  end
  
end
