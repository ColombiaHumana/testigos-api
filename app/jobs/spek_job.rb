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
      clave: "clave para poder acceder al servicio",
      imagen: "https://pbs.twimg.com/media/DYLbFd4WkAAzB-z.jpg"
    }
  end
end


# {
#   "mesa": {
#     "numero": 10,
#     "puesto": 10,
#     "zona": 10,
#     "municipio": 10,
#     "departamento": 10
#   },
#   "conteo":[
#     {"numero":1,"nombre":"GustavoPetro","votos":100},
#     {"numero":2,"nombre":"IvanDuque","votos":20},
#     {"numero":3,"nombre":"SergioFajardo","votos":20},
#     {"numero":4,"nombre":"HumbertoDelaCalle","votos":32}
#     ],
#   "clave": "clave para poder acceder al servicio",
#   "imagen": "https://pbs.twimg.com/media/DYLbFd4WkAAzB-z.jpg",
# }
