class SpekJob < ApplicationJob
  queue_as :default

  # POST result data to Spek
  def perform(result)
    json = {
      mesa: {
        numero: result.table.cod_table,
        puesto: result.table.post.cod_post,
        zona: result.table.zone.cod_zone,
        municipio: result.table.municipality.cod_municipality,
        departamento: result.table.department.cod_department
      },
      conteo: [
        { numero: 1, nombre: "GustavoPetro", votos: result.petro },
        { numero: 2, nombre: "IvanDuque", votos: result.duque },
        { numero: 3, nombre: "SergioFajardo", votos: result.fajardo },
        { numero: 4, nombre: "HumbertoDelaCalle", votos: result.la_calle }
      ],
      clave: Rails.application.credentials.spek_password,
      imagen: result.image
    }.to_json
    RestClient.post( Rails.application.credentials.spek_url,
      json,
      { content_type: :json, accept: :json }
    )
  end
end
