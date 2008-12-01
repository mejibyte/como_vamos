class CreateSolutions < ActiveRecord::Migration
  def self.up
    create_table :solutions do |t|
      t.text :explanation
      t.timestamps
    end
  end
  
  def self.down
    drop_table :solutions
  end
end
