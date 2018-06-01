class AddUserToCoordinators < ActiveRecord::Migration[5.2]
  def change
    add_reference :coordinators, :user, foreign_key: true
  end
end
