# frozen_string_literal: true

json.user do
  json.name @user.name
  json.email @user.email
  json.cedula @user.document
  json.coordinator @user.coordinator
  json.online @user.online
  json.email @user.email.present?
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
    json.coordinator do
      json.name @user.post.coordinator&.name
      json.phone @user.post.coordinator&.phone
    end
  end
  json.tables do
    json.array! @user.tables do |table|
      json.id table.id
      json.name "Mesa #{table.cod_table}"
    end
  end
  if @user.coordinator?
    json.users do
      json.array! @user.post.users.joins(:tables).where(uploaded: true).where.not(id: @user.id) do |user|
        json.id user.id
        json.name user.name
        json.document user.document
        json.phone user.phone
        json.tables do
          json.array! user.tables do |table|
            json.name "Mesa #{table.cod_table}"
          end
        end
      end
    end
  end
end
