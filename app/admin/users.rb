ActiveAdmin.register User do
  permit_params :name, :password, :password_confirmation, :email
  menu priority: 5
  config.filters = false
  config.batch_actions = false

  member_action :save_post, method: :post do
   resource.post_id = params[:post_id]
   resource.save!(validate: false)
   render json: {ok: true}
  end

  member_action :save_email, method: :post do
   resource.email = params[:email]
   resource.save!(validate: false)
   render json: {ok: true}
  end

  index :download_links => false, paginate: false do
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
  end
end
