require 'csv'

namespace :users do
  desc 'Load users'
  task load: :environment do
    rows_csv = File.read(Rails.root.join('vendor', 'divipol', 'users.csv'))
    csv = CSV.parse(rows_csv, headers: true)
    csv.each do | row |
      begin
        department = Department.find_by(cod_department: row['dd'])
        municipality = department.municipalities.find_by(cod_municipality: row['mm'])
        zone = municipality.zones.find_by(cod_zone: row['zz'])
        post = zone.posts.find_by(cod_post: row['pp'])
        user = User.find_by(document: row['cedula']) || User.create!(
          document: row['cedula'],
          name: row['nombre'],
          email: row['email'],
          password: row['password'],
          password_confirmation: row['password'],
          post: post
        )
        post.tables.find_by(cod_table: row['mesa']).update user: user
        # puts "Usuario: #{user.name}, Mesa: #{row['mesa']}"
        puts row
      rescue NoMethodError
        # n += 1
        # puts row
      end
    end

  end
end
