# frozen_string_literal: true

# User administration
ActiveAdmin.register User do
  permit_params :name, :first_name, :second_name, :surname,
                :second_surname, :password, :password_confirmation,
                :email, :phone
  menu priority: 5

  scope 'Postulados Coordinadores', :coordinators
  index do
    id_column
    column :name
    column :document
    column :email
    column :post
    column :municipality
    column :department
    actions
  end

  filter :department
  filter :municipality
  filter :email
  filter :name
  filter :document

  form do |f|
    f.inputs do
      f.input :name, input_html: { disabled: true }
      f.input :first_name
      f.input :second_name
      f.input :surname
      f.input :second_surname
      f.input :email
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    defaults finder: :find_by_token
  end

  csv do
    column :document
    column :name
    column :first_name
    column :second_name
    column :surname
    column :second_surname
    column :coordinator
    column :online
    column :verified_email
    column :confirmation
    column :gestion
    column :rejected
    column :enabled
    column('Departamento') { |u| u.department.name }
    column('DD') { |u| u.department.cod_department }
    column('Municipio') { |u| u.municipality.name }
    column('MM') { |u| u.department.cod_municipality }
    column('Zona') { |u| u.zone.cod_zone }
    column('Puesto') { |u| u.post.name }
    column('PP') { |u| u.post.cod_post }
  end
end
