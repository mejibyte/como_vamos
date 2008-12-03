class Judge < ActiveRecord::Base

  has_many :problems, :dependent => :destroy
  belongs_to :owner, :class_name => "User"

  validates_presence_of :name, :url
  validate :url_is_valid


  def editable_by?(user)
    return false unless !user.nil?
    return true if user.is_admin? || user.is_moderator? || self.owner == user
    return false
    #only admins, moderator, or owners can edi
  end

  def deletable_by?(user)
    return false unless !user.nil?
    return true if user.is_admin? || user.is_moderator? || self.owner == user
    return false
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
