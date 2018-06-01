ActiveAdmin.register_page "Usuarios" do

  menu priority: 1, label: 'Testigos'

  # member_action :save_post, method: :post do
  #
  # end

  content title: "Validar testigos" do
    @user = User.where(enabled: false).where.not(phone: nil).sample
    columns do
      column do
        panel "#{@user.name}" do
          render 'user_form', {user: @user}
        end
      end
    end
    columns do
      column do
        panel "Modificar datos" do
          render 'form', {user: @user}
        end
      end
    end
  end # content
end
