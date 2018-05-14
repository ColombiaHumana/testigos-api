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
              render 'logins', { number: "98%", icon: "percent" }
            end
          end
        end # End panel
      end # End column

      column do
        panel "Testigos de muestreo logueados" do

        end # End panel
      end # End column
    end # End columns
  end
end
