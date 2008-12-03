class AddOwnerToProblemAndJudge < ActiveRecord::Migration
  def self.up
    add_column :problems, :owner_id, :integer
    add_column :judges, :owner_id, :integer
  end

  def self.down
    remove_column :problems, :owner_id
    remove_column :judge, :owner_id
  end
end
