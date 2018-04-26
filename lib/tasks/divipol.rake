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
        cod_department: centro['dd'],
        cod_municipality: centro['mm'],
        department: department,
        name: centro['municipio']
      ).first_or_create
      zone = Zone.where(
        department: department,
        municipality: municipality,
        name: centro['comuna']
      ).first_or_create
      post = Post.create(
        address: centro['direccion'],
        cod_post: centro['pp'],
        department: department,
        mens: centro['hombres'],
        municipality: municipality,
        name: centro['puesto'],
        mesas: centro['mesas'],
        womens: centro['mujeres'],
        zone: zone
      )
      post.mesas.times do |i|
        mesa = i + 1
        post.tables.create!(
          department: department,
          municipality: municipality,
          table_number: mesa,
          zone: zone,
          name: "Mesa #{mesa}"
        )
      end
    end
  end
end
