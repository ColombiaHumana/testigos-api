ActiveAdmin.register User do
  menu priority: 5
  index do
    id_column
    column :name
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
