json.array! @computed.each do |department|
  json.array! [
    department[:department],
    department[:petro_ponderado].round,
    department[:duque_ponderado].round,
    department[:blancos_ponderado].round
  ]
end
