ActiveAdmin.register_page "Incidencias" do
  menu priority: 4
  content title: "Testigos de muestreo" do
    columns do
      column do
        panel "Incidencias" do
          render 'graph', { issues: Report.joins(:issue).group('issues.name').count }
        end
      end
    end
  end
end
