Fabricator(:business) do
  name {Faker::Lorem.words(2).join(" ")}
  description {Faker::Lorem.sentence}
end