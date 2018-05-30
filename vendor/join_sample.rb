sample=Table.order(order: 'asc').where(sample: true).joins(:result)

File.open('/home/capistrano/sample.csv', 'w') do |file|
  sample.each do |s|
    file << "#{s.department.name},#{s.department.cod_department},#{s.municipality.name},#{s.municipality.cod_municipality},#{s.zone.cod_zone},#{s.post.name},#{s.post.cod_post},#{s.cod_table},#{s.order},#{s.result.total},#{s.result.petro},#{s.result.duque},#{s.result.fajardo},#{s.result.vargas},#{s.result.la_calle},#{s.result.trujillo},#{s.result.morales},#{s.result.promotores},#{s.result.votos_blancos},#{s.result.votos_nulos},#{s.result.votos_no_marcados},#{s.result.votos_validos}\n"
  end
end
