json.array! @departments.each do |data|
  json.name data[:name]
  json.data data[:data]
end
