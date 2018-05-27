ActiveAdmin.register_page "Mesas" do
  menu priority: 2, label: 'Mesas por escrutar'

  content title: "Mesas de muestreo" do
    columns do
      column do
        panel "Mesas no escrutadas" do
          paginated_collection(Table.where(sample: true).includes(:result).where(results: {id: nil}).page(params[:page]).per(20)) do
            table_for collection do
              column('Nro Orden MT') { |table| table.order }
              column('Departamento') { |table| table.post.department.name }
              column('Municipio') { |table| table.post.municipality.name }
              column('Puesto') { |table| table.post.name }
              column do |table|
                link_to 'Agregar Resultado', result_admin_table_path(table)
              end
            end
          end
        end
      end
    end

    # columns do
    #   column do
    #     panel "" do
    #       table_for Department.order('name asc').where(id: 1..33).each do
    #         column('Departamento') { |department| department.name }
    #         column('Peso') { |department| "#{number_to_percentage((department.weight * 100.0), precision: 2)}" }
    #         Tablas.each do | name, index |
    #           column(name) { |department| department.results.pluck(:votes).inject(0) { |sum, hash| sum + hash[index] } }
    #         end
    #       end
    #     end
    #   end
    # end

  end

end
