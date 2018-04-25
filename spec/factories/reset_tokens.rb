# frozen_string_literal: true

FactoryBot.define do
  factory :reset_token do
    token ''
    user nil
  end
end
