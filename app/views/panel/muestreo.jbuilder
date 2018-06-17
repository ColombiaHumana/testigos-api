json.tables do
  json.total Table.muestreo.count
  json.reported Table.muestreo.escrutado.count
  json.percent (Table.muestreo.escrutado.count * 100.0 / Table.muestreo.count.to_f).round(2)
end

json.votes do
  json.petro @totales[:petro].round
  json.petroPercent (@totales[:petro] * 100.0 / @totales[:total]).round(2)
  json.duque @totales[:duque].round
  json.duquePercent (@totales[:duque] * 100.0 / @totales[:total]).round(2)
  json.blanco @totales[:blancos].round
  json.blancoPercent (@totales[:blancos] * 100.0 / @totales[:total]).round(2)
  json.nulls @totales[:nulos].round
  json.nullsPercent (@totales[:nulos] * 100.0 / @totales[:total_s]).round(2)
  json.invalids @totales[:no_marcados].round
  json.invalidsPercent (@totales[:no_marcados] * 100.0 / @totales[:total_s]).round(2)
end
