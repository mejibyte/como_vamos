class CreateJudges < ActiveRecord::Migration
  def self.up
    create_table :judges do |t|
      t.string :name
      t.string :url
      t.timestamps
    end
  end
  
  def self.down
    drop_table :judges
  end
end
