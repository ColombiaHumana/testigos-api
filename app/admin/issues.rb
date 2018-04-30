ActiveAdmin.register Issue do
  menu priority: 4

  index do
    selectable_column
    id_column
    column :name
    actions
  end

end
