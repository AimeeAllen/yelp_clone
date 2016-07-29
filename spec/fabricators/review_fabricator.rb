Fabricator(:review) do
  body {Faker::Lorem.sentence}
  business
  user
end