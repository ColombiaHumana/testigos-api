# frozen_string_literal: true

json.user do
  json.name @user.name
  json.email @user.email
  json.coordinator @user.coordinator
  json.post do
    json.id @user.post.id
    json.name @user.post.name
    json.department do
      json.id @user.department.id
      json.name @user.department.name
    end
    json.municipality do
      json.id @user.municipality.id
      json.name @user.municipality.name
    end
    json.zone do
      json.id @user.zone.id
      json.name @user.zone.name
    end
    json.tables do
      @user.tables.each do |table|
        json.id table.id
        json.name table.name
      end
    end
  end
end
