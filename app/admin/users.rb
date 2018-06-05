ActiveAdmin.register User do
  permit_params :name, :first_name, :second_name, :surname, :second_surname, :password, :password_confirmation, :email
  menu priority: 5
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
      f.input :second_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
