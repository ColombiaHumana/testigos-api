# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    if AdminAbility.new(current_admin_user).can? :manage, :all
      columns do
        column do
          panel 'Votos totales' do
            data = Result.all.pluck(:votes).reduce({}) { |h, acc| acc.merge(h) {|_k, o, n| o+n } }.without('promotores','total','total_mesa','votos_nulos', 'votos_blancos', 'votos_validos', 'votos_no_marcados')
            render 'bar_graph', data: data
          end
        end
      end
    end
  end
end
