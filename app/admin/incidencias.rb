ActiveAdmin.register_page "Incidencias" do
  menu priority: 4
  content title: "Testigos de muestreo" do
    columns do
      column do
        panel "Incidencias" do
          render 'graph', { issues: Report.joins(:issue).group('issues.name').count }
        end # end panel
      end # end colum
      column do
        panel "Incidencias por tipo" do
          table_for Report.joins(:issue).group('issues.name').count.each do
            column('Tipo') { |issue| issue.first }
            column('Cantidad') { |issue| issue.last }
          end
        end
      end # end column
    end # end columns
  end # end content
end
