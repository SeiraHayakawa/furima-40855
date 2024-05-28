FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.email}
    password              {'000aaa'}
    password_confirmation {password}
    family_name           {'テスト'}
    first_name            {'太郎'}
    family_name_kana      {'テスト'}
    first_name_kana       {'タロウ'}
    birth_day             {'2000-08-24'}
  end
end