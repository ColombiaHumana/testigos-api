ActiveAdmin.register_page "Escrutinio" do
  menu priority: 2
  content title: "Resumen de escrutinio" do
    columns do
      column do
        panel "Mesas escrutadas por departamento" do
          @totales = {}
          @escrutados = {}
          table_for Department.order('name asc').where(id: 1..33).each do
            column('Departamento') { |department| department.name }
            column('Total de mesas') { |department| @totales[department.map] = department.tables.where(sample: true).count }
            column('Escrutadas') { |department| @escrutados[department.map] = department.tables.where(sample: true).joins(:result).count }
            column('Porcentaje Escrutado') { |department| number_to_percentage((@escrutados[department.map] * 100.0) / (@totales[department.map].nonzero? || 1), precision: 2) }
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
