ActiveAdmin.register_page "Proyecciones" do
  menu priority: 2

  Tablas = [
    ["Gustavo Petro", 'petro'],
    ["Promotores voto blanco", 'promotores'],
    ["Ivan Duque", 'duque'],
    ["Humberto de la Calle", 'la_calle'],
    ["José Antonio Trujillo", 'trujillo'],
    ["Sergio Fajardo", 'fajardo'],
    ["Viviane Morales", 'morales'],
    ["Vargas Lleras", 'vargas'],
    ["Voto blanco", 'votos_blancos']
  ]

  content title: "Proyección de resultados" do
    columns do
      column do
        panel "Proyección de resultados" do
          @directos = {}
          @total_ponderado = 0
          @results = {}
          @votes = Table.where(sample: true).map { |table| table.result.votes unless table.result.nil? }.compact
          @escrutado = Department.sum(:scrutinized)
          table_for Tablas.each do

            column('Lista') { |lista| lista.first }
            column('Votos directos') do |lista|
              @directos[lista.first] = @votes.inject(0) { |sum, hash| sum + hash[lista.last] || 0 }
              number_with_delimiter(@directos[lista.first], delimiter: ".")
            end
            column('% Votos directos') do |lista|
              number_to_percentage((@directos[lista.first] * 100 / @escrutado.to_f), precision: 2)
            end

            column('Votos ponderados') do |lista|
              @ponderado = 0
              Department.where(id: 1..33).each do |department|
                directos = department.tables.where(sample: true).map { |table| table.result.votes unless table.result.nil? }.compact.inject(0){ |sum, hash| sum + hash[lista.last] }
                @ponderado += directos * department.coefficient
              end
              @total_ponderado += @ponderado
              @results[lista.last] = @ponderado
              number_with_delimiter(@results[lista.last].to_i, delimiter: ".")
            end

            column('% Votos ponderados') do |lista|
              number_to_percentage((@results[lista.last] / @total_ponderado) * 100, precision: 2)
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
