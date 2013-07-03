# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id  100
    name "Petya"
    email "petya@gmail.com"
  end
end
