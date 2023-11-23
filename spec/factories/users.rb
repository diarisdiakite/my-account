FactoryBot.define do
  factory :user do
    name { 'example_user' }
    description { 'description 1' }
    photo { 'description 1' }
    bio { 'description 1' }
  end

  factory :user_two, class: User do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    photo { 'path_to_user_photo.jpg' }
    bio { Faker::Lorem.paragraph }
  end
end
