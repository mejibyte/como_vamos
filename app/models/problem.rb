class Problem < ActiveRecord::Base
  belongs_to :judge


  validates_presence_of :title, :url, :judge_id
  validate :url_is_valid

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
