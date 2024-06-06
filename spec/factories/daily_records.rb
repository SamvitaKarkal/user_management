FactoryBot.define do
  factory :daily_record do
    date { Date.today }
    male_count { 0 }
    female_count { 0 }
  end
end