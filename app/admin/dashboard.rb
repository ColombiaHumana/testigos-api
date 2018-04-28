ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Tiempo real" do

        end
      end

      column do
        panel "Estadísticas" do
          render partial: 'statistics'
        end
      end
    end
  end # content
end
