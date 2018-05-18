require 'csv'
namespace :divipol do
  desc "Load DIVIPOL CSV"
  task load: :environment do
    divipol_csv = File.read(Rails.root.join('vendor', 'divipol', 'divipol.csv'))
    csv = CSV.parse(divipol_csv, headers: true)
    csv.each do |centro|
      department = Department.where(
        cod_department: centro['dd'],
        name: centro['departamento']
      ).first_or_create
      municipality = Municipality.where(
        cod_municipality: centro['mm'],
        department: department,
        name: centro['municipio']
      ).first_or_create
      zone = Zone.where(
        municipality: municipality,
        name: centro['comuna'],
        cod_zone: centro['zz']
      ).first_or_create
      post = Post.create(
        name: centro['puesto'],
        cod_post: centro['pp'],
        zone: zone,
        males: centro['hombres'],
        females: centro['mujeres'],
        address: centro['direccion']
      )
      centro['mesas'].to_i.times do |i|
        mesa = i + 1
        post.tables.create!(
          cod_table: mesa
        )
      end
    end
  end
end
