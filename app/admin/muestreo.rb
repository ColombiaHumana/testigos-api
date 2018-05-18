ActiveAdmin.register_page "Muestreo" do
  menu priority: 2
  content title: "Testigos de muestreo" do

    columns do
      column do
        panel "Testigos de muestreo logueados" do
          columns do
            column do
              render 'logins', { number: User.count, icon: "user" }
            end
            column do
              render 'logins', { number: "33%", icon: "percent" }
            end
          end
          columns do
            column do
              render 'login_chart'
            end
          end
        end # End panel
        panel "Testigos en el mapa" do
          columns do
            column do
              render 'map_chart'
            end
          end
        end
      end # End column

      column do
        panel "Testigos de muestreo logueados por departamento" do
          table_for Department.all do
            column("Departamento") {| department | department.name }
            column("Logueados") { | department | department.users.count }
            column("Porcentaje") { | department | "#{department.users.count * 100/9} %" }
          end
        end # End panel
      end # End column
    end # End columns
  end
end
