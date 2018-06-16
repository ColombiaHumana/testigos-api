json.array! @departments.orden.each do |department|
  json.array! [
    department.name,
    department.rounds.total_petro,
    department.rounds.total_duque,
    department.rounds.total_blancos
  ]
end
