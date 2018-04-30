ActiveAdmin.register Report do
  index do
    id_column
    column :table
    column :post
    column :zone
    column :municipality
    column :department
    column :issue
    column :user
  end

  filter :user
  filter :issue
end
