ActiveAdmin.register News do
  menu priority: 3
  index do
    selectable_column
    id_column
    column :title
    column :content
    column :public
    actions
  end
  filter :title
  filter :content
end
