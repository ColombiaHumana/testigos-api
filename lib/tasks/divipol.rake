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
        cod_zone: centro['zz']
      ).first_or_create
      post = Post.create!(
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

  desc 'Load sample tables'
  task sample: :environment do
    sample_csv = File.read(Rails.root.join('vendor', 'divipol', 'sample.csv'))
    CSV.parse(sample_csv, headers: true).each do |row|
      begin
        Department.find_by(cod_department: row['dd'])
        .municipalities.find_by(cod_municipality: row['mm'])
        .zones.find_by(cod_zone: row['zz'])
        .posts.find_by(cod_post: row['pp'])
        .tables.find_by(cod_table: row['mesa'])
        .update order: row['orden'], sample: true

      rescue
        puts row
      end
    end
  end
end
