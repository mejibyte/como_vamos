require 'uri'
class Problem < ActiveRecord::Base
  belongs_to :judge
  has_many :solutions, :dependent => :destroy
  has_many :solvers, :through => :solutions, :source => :user
  belongs_to :owner, :class_name => "User"

  validates_presence_of :title, :url, :number, :judge_id
  validates_uniqueness_of :number, :scope => [:judge_id]
  validates_uniqueness_of :url

  validate :url_is_valid
  
  make_permalink :title
  
  named_scope :solved, :joins => :solutions
  named_scope :unique, :select => "DISTINCT problems.*"
  named_scope :solved_recently, :joins => :solutions, :order => "solutions.created_at DESC"
  named_scope :limit, lambda {|*args| {:limit => args.first || 10}}

  def full_title
    "#{number} - #{title}"
  end

  def to_param
    permalink
  end

  def solved?
    self.solutions.any?
  end

  def solved_by?(user)
    self.solvers.include?(user)
  end

  def self.unsolved_problems
    Problem.all.select { |p| not p.solved? }
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
