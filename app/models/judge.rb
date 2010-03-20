class Judge < ActiveRecord::Base

  has_many :problems, :dependent => :destroy, :order => "number, title ASC"
  belongs_to :owner, :class_name => "User"

  validates_presence_of :name, :url
  validate :url_is_valid
  
  make_permalink :name

  def self.all_sorted
    self.all :order => "name ASC"
  end
  
  def to_param
    permalink
  end

  protected
  def url_is_valid
    begin
      uri = URI.parse(url)
      if uri.class != URI::HTTP
        errors.add(:url, 'Only HTTP protocol addresses can be used')
      end
    rescue URI::InvalidURIError
      errors.add(:url, 'The format of the url is not valid.')
    end
  end

end
