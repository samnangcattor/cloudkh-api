class AddAvatarToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :address, :string
    add_column :users, :avatar, :string
  end
end
