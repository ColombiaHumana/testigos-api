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
        { numero: 3, nombre: "IVÁN DUQUE", votos: result.duque },
        { numero: 996, nombre: "VOTOS EN BLANCO", votos: result.blanco },
        { numero: 997, nombre: "VOTOS NULOS", votos: result.nulos },
        { numero: 998, nombre: "VOTOS NO MARCADOS", votos: result.no_marcados }
      ],
      "TOTAL SUFRAGANTES": result.total_e11,
    	"TOTAL VOTOS EN LA URNA": result.total_urna,
    	"TOTAL VOTOS INCINERADOS": result.total_incinerados,
    	"TOTAL VOTOS DE LA MESA": result.total_mesa,
      clave: Rails.application.credentials.spek_password,
      imagen: result.image
    }.to_json
    begin
      RestClient.post( Rails.application.credentials.spek_url,
        json,
        { content_type: :json, accept: :json }
      )
    rescue RestClient::PreconditionFailed
    end
  end
end
