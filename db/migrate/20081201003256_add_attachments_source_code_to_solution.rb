class AddAttachmentsSourceCodeToSolution < ActiveRecord::Migration
  def self.up
    add_column :solutions, :source_code_file_name, :string
    add_column :solutions, :source_code_content_type, :string
    add_column :solutions, :source_code_file_size, :integer
    add_column :solutions, :source_code_updated_at, :datetime
  end

  def self.down
    remove_column :solutions, :source_code_file_name
    remove_column :solutions, :source_code_content_type
    remove_column :solutions, :source_code_file_size
    remove_column :solutions, :source_code_updated_at
  end
end
