FactoryGirl.define do
  factory :session do
    user
    version '0.1'

    trait :not_ended do
      started_at { 1.hour.ago }
    end

    trait :hour_long do
      started_at { 1.hour.ago }
      ended_at { Time.now }
    end
  end
end
