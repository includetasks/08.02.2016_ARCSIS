FactoryGirl.define do
  factory :user do
    first_name         Faker::Name.first_name
    last_name          Faker::Name.last_name
    phone              Faker::PhoneNumber.phone_number
    is_active          [true, false].sample
    sequence(:email)   { |n| "email#{n}@gmail.com" }
    password           'atata123___'
    encrypted_password Devise::Encryptor.digest(User, 'atata123___')

    factory :another_user
    factory :active_user do
      is_active true
    end

    factory :inactive_user do
      is_active false
    end
  end
end
