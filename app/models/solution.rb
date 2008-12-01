class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  validates_presence_of :explanation, :problem_id, :user_id



  has_attached_file :source_code,
                    :url => "/uploads/solutions/:id_:basename.:extension",
                    :path => ":rails_root/public/uploads/solutions/:id_:basename.:extension"


  validates_presence_of :source_code_file_name

  validate :source_code_has_valid_extension

  def accepted_extensions
    ["cpp", "cc", "c", "pas", "java"]
  end

  def source_code_as_text
    filename = source_code.url.gsub(/\?.*/, "")
    begin
      "\n" + File.read(RAILS_ROOT + "/public/" + filename)
    rescue
      "There was an error while reading the source file."
    end
  end

  protected
  def source_code_has_valid_extension
    extension = (source_code_file_name || " . ").split(".").last.downcase
    unless accepted_extensions.include?(extension)
      errors.add(:source_code, " has invalid extension. Supported: #{accepted_extensions.inspect}")
    end
  end
end
