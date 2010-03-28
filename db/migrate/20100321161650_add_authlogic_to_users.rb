class AddAuthlogicToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :persistence_token, :string
    add_column :users, :login_count, :integer, :null => false, :default => 0
    add_column :users, :last_login_at, :string
  end

  def self.down
    remove_column :users, :last_login_at
    remove_column :users, :login_count
    remove_column :users, :persistence_token
  end
end
