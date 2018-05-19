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
        { numero: 1, nombre: "GustavoPetro", votos: 100 },
        { numero: 2, nombre: "IvanDuque", votos: 100 },
        { numero: 3, nombre: "SergioFajardo", votos: 100 },
        { numero: 4, nombre: "HumbertoDelaCalle", votos: 100 }
      ],
      clave: Rails.application.credentials.spek_password,
      imagen: "https://pbs.twimg.com/media/DYLbFd4WkAAzB-z.jpg"
    }.to_json
    RestClient.post( Rails.application.credentials.spek_url,
      json,
      { content_type: :json, accept: :json }
    )
  end
end
