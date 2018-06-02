class AddUserToCoordinadores < ActiveRecord::Migration[5.2]
  def change
    add_reference :coordinadores, :user, foreign_key: true
  end
end
