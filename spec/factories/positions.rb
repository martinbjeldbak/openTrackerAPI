# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    x Random.rand(-100...1000)
    y Random.rand(-100...1000)
    z Random.rand(-100...1000)

    speed 2
    rpm 1500
    gear 3
    on_gas true
    on_brake false
    on_clutch false
    steer_rot 3
  end
end
