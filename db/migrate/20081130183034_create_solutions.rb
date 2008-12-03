class CreateSolutions < ActiveRecord::Migration
  def self.up
    create_table :solutions do |t|
      t.text :explanation
      t.integer :problem_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :solutions
  end
end
