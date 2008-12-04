class AddWantEmailsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :wants_emails, :boolean
  end

  def self.down
    remove_column :users, :wants_emails
  end
end
