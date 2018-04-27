# frozen_string_literal: true

json.user do
  json.name @user.name
  json.email @user.email
  json.coordinator @user.coordinator
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
  json.post do
    json.id @user.post.id
    json.name @user.post.name
  end
  json.tables do
    json.array! @user.tables do |table|
      json.id table.id
      json.name "Mesa #{table.cod_table}"
    end
  end
end
