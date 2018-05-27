ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation, :email
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
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
