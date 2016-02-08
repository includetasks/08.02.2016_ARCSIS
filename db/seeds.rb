seed_params = { user_count: 60 }

seed_params[:user_count].times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.phone_number,
    is_active: [true, false].sample,
    email: Faker::Internet.email,
    password: 'atata123___',
    password_confirmation: 'atata123___'
  )
end
