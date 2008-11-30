class AddNumberToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :number, :string
  end

  def self.down
    remove_column :problems, :number
  end
end
