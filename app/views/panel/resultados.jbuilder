json.tables do
  json.total Table.validas.count
  json.reported Table.validas.escrutado.count
  json.percent (Table.validas.escrutado.count * 100 / Table.validas.count.to_f).round(2)
end

json.votes do
  json.petro @totales_validas[:petro].round
  json.petroPercent (@totales_validas[:petro] * 100.0 / @totales_validas[:total]).round(2)
  json.duque @totales_validas[:duque].round
  json.duquePercent (@totales_validas[:duque] * 100.0 / @totales_validas[:total]).round(2)
  json.blanco @totales_validas[:blancos].round
  json.blancoPercent (@totales_validas[:blancos] * 100.0 / @totales_validas[:total]).round(2)
  json.nulls @totales_validas[:nulos].round
  json.nullsPercent (@totales_validas[:nulos] * 100.0 / @totales[:total]).round(2)
  json.invalids @totales_validas[:no_marcados].round
  json.invalidsPercent (@totales_validas[:no_marcados] * 100.0 / @totales[:total]).round(2)
end
