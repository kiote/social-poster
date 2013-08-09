# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :authorisation do
    provider "provider"
    uid "uid"
    token "token"
    secret "secret"
  end

  factory :auth_facebook, class: Authorisation do
    provider "facebook"
    uid "100005133014329"
    token "CAAHtNEnQEmcBACbxZCVp7AzHEQ2CD3KhEMwwEtBpXgTZCXMy2ZAwZCUZCrfoVztniwUlSSUsdTOZCyDSZC70q4JAycuYlSOea9dvWltBNHFDuEscrAt0Ql3Yv5kZCZApGED0n5anZAZBB65TzXqoyvA3wrk"
    secret "secret"
  end
  
  factory :auth_linkedin, class: Authorisation do
    provider "linkedin"
    uid "EsKOV6HBMr"
    token "2d19df97-5c12-4ed0-80b0-5879109bf6ec"
    secret "b1dc687d-2a64-42e2-8300-fa3b161f0630"
  end
  
  factory :auth_tumblr, class: Authorisation do
    provider "tumblr"
    uid "uid"
    token "token"
    secret "secret"
  end
  
  factory :auth_twitter, class: Authorisation do
    provider "twitter"
    uid "1497573638"
    token "1497573638-k31hUR783ken3ntgBvhY6zgrjXpBjBzLrjPcgIL"
    secret "nO9RwUZU1fLztIzeZOLLkXDVoqOmE9an5BDujAtmo"
  end
  
  factory :auth_vkontakte, class: Authorisation do
    provider "vkontakte"
    uid "uid"
    token "token"
    secret "secret"
  end
  
end
