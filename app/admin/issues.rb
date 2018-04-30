ActiveAdmin.register Issue do
  menu priority: 4
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

end
