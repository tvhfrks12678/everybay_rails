FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name "Aaron"
    last_name "Sumer"
    sequence(:email) { |n| "tester#{n}@example.com" } 
    password "dottle-nouveau-pavilion-tights-furze"
  end
end
