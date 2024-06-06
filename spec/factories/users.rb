FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    age { 30 }
    gender { "male" }
    uuid { "1234m8e90" }
  end
end
