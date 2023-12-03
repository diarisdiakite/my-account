FactoryBot.define do
  factory :category do
    # user { nil }
    name { 'MyName' }
    icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png') }
    association :user
  end
end
