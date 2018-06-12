# frozen_string_literal: true

json.mesas @tables.each do |table|
  json.id table.id
  json.nombre table.name
end
