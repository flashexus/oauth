class AddOmniauthToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :raw, :text
  end
end
