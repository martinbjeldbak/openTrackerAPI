# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    x Random.rand(-100...1000)
    y Random.rand(-100...1000)
    z Random.rand(-100...1000)
  end
end
