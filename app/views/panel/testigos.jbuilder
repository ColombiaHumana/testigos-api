json.reported do
  json.total @total
  json.reported @reported
  json.percent @reported_percent
end
json.login do
  json.total @total
  json.logged @logged
  json.percent @logged_percent
end
