# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lap do
    lap_nr 1

    session { FactoryGirl.create(:session) }
  end
end
