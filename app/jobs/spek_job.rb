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
        { numero: 1, nombre: "GUSTAVO PETRO", votos: result.petro },
        { numero: 2, nombre: "PROMOTORES VOTO EN BLANCO", votos: result.promotores },
        { numero: 3, nombre: "IVÁN DUQUE", votos: result.duque },
        { numero: 4, nombre: "HUMBERTO DE LA CALLE", votos: result.la_calle },
        { numero: 5, nombre: "JORGE ANTONIO TRUJILLO SARMIENTO", votos: result.trujillo },
        { numero: 6, nombre: "SERGIO FAJARDO", votos: result.fajardo },
        { numero: 7, nombre: "VIVIANE MORALES", votos: result.morales },
        { numero: 8, nombre: "GERMÁN VARGAS LLERAS", votos: result.vargas },
        { numero: 996, nombre: "VOTOS EN BLANCO", votos: result.votos_blancos },
        { numero: 997, nombre: "VOTOS NULOS", votos: result.votos_nulos },
        { numero: 998, nombre: "VOTOS NO MARCADOS", votos: result.votos_no_marcados }
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
