class Problem < ActiveRecord::Base
  belongs_to :judge
  has_many :solutions, :dependent => :destroy

  has_many :solvers, :through => :solutions, :source => :user

  validates_presence_of :title, :url, :number, :judge_id
  validates_uniqueness_of :number, :scope => [:judge_id]
  validates_uniqueness_of :url

  validate :url_is_valid

  def full_title
    "#{number} - #{title}"
  end

  def self.unsolved_problems
    result = []
    for p in Problem.all
      result << p unless p.solvers.size > 0
    end
    result
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
