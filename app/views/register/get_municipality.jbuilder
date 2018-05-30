json.array! @municipalities do |municipality|
  json.id municipality.id
  json.name municipality.name.titleize
end
