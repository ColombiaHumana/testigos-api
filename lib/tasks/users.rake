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
        # puts row
      rescue NoMethodError
      #   # n += 1
        puts row
      end
    end

  end

  desc 'Load emails'
  task emails: :environment do
    emails_csv = File.read(Rails.root.join('vendor', 'divipol', 'emails.csv'))
    csv = CSV.parse(emails_csv, headers: true)
    csv.each do |row|
      begin
        user = User.find_by(document: row['cedula'])
        if Devise::email_regexp.match?(row['email']) && user.email != row['email']
          user.update email: row['email']
          token = user.reset_tokens.create
          PasswordMailer.create(token).deliver_later
        end
      rescue
        next
      end
    end
  end

  desc 'Load users with emails'
  task load_email: :environment do
      users_csv = File.read(Rails.root.join('vendor', 'divipol', 'divipol_users.csv'))
      csv = CSV.parse(users_csv, headers: true)
      csv.each do |row|
        begin
          department = Department.find_by(name: row['departamento'])
          municipality = department.municipalities.find_by(name: row['municipio'])
          zone = municipality.zones.find_by(cod_zone: row['zz'])
          post = zone.posts.find_by(cod_post: row['pp'])
          user = User.find_by(document: row['cedula']) || User.create!(
            document: row['cedula'],
            name: row['nombre'],
            email: row['email'],
            password: row['password'],
            password_confirmation: row['password'],
            post: post,
            phone: row['phone']
          )
          post.tables.find_by(cod_table: row['mesa']).update user: user
          if user.id_previously_changed? && /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match?(row['email'])
            token = user.reset_tokens.create
            PasswordMailer.create(token).deliver_later
          end
        rescue
          puts row
        end
      end
  end

  desc 'Send invitation email'
  task invitation: :environment do
    User.where.not(email: nil).each do |user|
      PasswordMailer.invitation(user).deliver_later
    end
  end
end
