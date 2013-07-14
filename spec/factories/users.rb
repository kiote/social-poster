# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    name "Savva"
    email "vcabba@rambler.ru"
    password "qqqwww"
    password_confirmation "qqqwww"
  end
  
end
