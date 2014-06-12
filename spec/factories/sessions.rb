FactoryGirl.define do
  factory :session do
    user
    ot_version '0.1'
    ac_version '0.9'
    user_agent 'rspec'

    trait :not_ended do
      started_at { 1.hour.ago }
    end

    trait :hour_long do
      started_at { 1.hour.ago }
      ended_at { Time.now }
    end

    trait :has_key do
      key { Key.create! }
    end
  end
end