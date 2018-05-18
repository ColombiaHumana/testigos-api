# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    document { Faker::Number.number(10) }
    name { Faker::Name.name }
    password '12345678'
    password_confirmation '12345678'
  end
end
