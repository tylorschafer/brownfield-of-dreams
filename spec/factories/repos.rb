# frozen_string_literal: true

FactoryBot.define do
  factory :repo do
    name { Faker::Name.unique.name }
    html_url { 'https://www.google.com' }
  end
end
