class ModifyUsers < ActiveRecord::Migration
  def change
    rename_column :users, :name, :username

    remove_column :users, :email
  end
end
