FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  sequence :uid do
    SecureRandom.hex
  end

  sequence :password do
    Devise.friendly_token[0,20]
  end

  sequence :name do |n|
    "name#{n}"
  end
end