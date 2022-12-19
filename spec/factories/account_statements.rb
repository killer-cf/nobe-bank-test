FactoryBot.define do
  factory :account_statement do
    name { "MyString" }
    moved_value { "9.99" }
    move_date { "2022-12-19" }
    client { nil }
  end
end
