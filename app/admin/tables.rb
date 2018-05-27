ActiveAdmin.register Table do
  menu priority: 2, label: 'Mesas'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
config.sort_order = 'order_asc'
  scope :muestreo, default: true
  filter :order

  actions :index, :result
  member_action :result do
    @result = resource.result || resource.build_result
  end

  member_action :create_result, method: %i{patch post} do
    votes = params.require(:result).permit(
      :petro,
      :promotores,
      :duque,
      :la_calle,
      :trujillo,
      :fajardo,
      :morales,
      :vargas,
      :votos_validos,
      :votos_blancos,
      :votos_nulos,
      :votos_no_marcados,
      :total
    ).merge(total_mesa: params[:result][:total].to_i)

    votes.to_h.collect { |k,v| votes[k] = v.to_i }
    resource.create_result! table_id: params[:result][:table_id].to_i, votes: votes.to_json, user: User.last if resource.result.nil?
    resource.result.update! table_id: params[:result][:table_id].to_i, votes: votes.to_json, user: User.last unless resource.result.nil?
    redirect_to admin_tables_path, notice: "Resultado guardado correctamente"
  end

  index do
    column :order
    column :department
    column :municipality
    column :post
    column :cod_table
    actions do |table|
      link_to 'Agregar Resultado', result_admin_table_path(table)
    end
  end

end
