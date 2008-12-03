class AddIsModeratorToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :is_moderator, :boolean
  end

  def self.down
    remove_column :users, :is_moderator
  end
end
