require 'digest/sha1'
class User < ActiveRecord::Base

  acts_as_authentic

  has_many :solutions, :dependent => :destroy
  has_many :solved_problems, :through => :solutions, :source => :problem

  has_many :created_problems, :class_name => "Problem", :foreign_key => "owner_id", :dependent => :nullify
  has_many :created_judges, :class_name => "Judge", :foreign_key => "owner_id", :dependent => :nullify

  # Virtual attribute for the unencrypted password
  # attr_accessor :password
  

  validates_presence_of     :login, :email, :name
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false

  # before_save :encrypt_password
  
  make_permalink :login

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  # attr_accessible :login, :email, :password, :password_confirmation, :name, :wants_emails
  attr_accessible :login, :name, :email, :password, :password_confirmation, :wants_emails

  named_scope :want_emails, :conditions => {:wants_emails => true}

  def to_param
    permalink
  end

  # # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  # def self.authenticate(login, password)
  #   u = find_by_login(login) # need to get the salt
  #   u && u.authenticated?(password) ? u : nil
  # end
  # 
  # # Encrypts some data with the salt.
  # def self.encrypt(password, salt)
  #   Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  # end
  # 
  # # Encrypts the password with the user salt
  # def encrypt(password)
  #   self.class.encrypt(password, salt)
  # end
  # 
  # def authenticated?(password)
  #   crypted_password == encrypt(password)
  # end
  # 
  # def remember_token?
  #   remember_token_expires_at && Time.now.utc < remember_token_expires_at
  # end
  # 
  # # These create and unset the fields required for remembering users between browser closes
  # def remember_me
  #   remember_me_for 2.weeks
  # end
  # 
  # def remember_me_for(time)
  #   remember_me_until time.from_now.utc
  # end
  # 
  # def remember_me_until(time)
  #   self.remember_token_expires_at = time
  #   self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
  #   save(false)
  # end
  # 
  # def forget_me
  #   self.remember_token_expires_at = nil
  #   self.remember_token            = nil
  #   save(false)
  # end
  # 
  # # Returns true if the user has just been activated.
  # def recently_activated?
  #   @activated
  # end

  def superuser?
    self.is_admin? || self.is_moderator?
  end

  def owns?(record)
    record.owner == self
  end


  def authorized?(record)
    #authorized for edit/delete.
    case record.class.to_s
    when "Judge"
      superuser? || owns?(record)
    when "Problem"
      superuser? || owns?(record)
    when "Solution"
      superuser? || self == record.user
    when "User"
      self.is_admin? || self == record
    else
      false
    end
  end

  # Find problems that other people has solved but I haven't.
  def missing_problems
    Problem.all.select { |p| p.solved? and not p.solved_by?(self)}
  end

  # Returns the email addresses as an array of strings.
  def self.emails(options = {})
    eligible = find_all_by_wants_emails(true)
    eligible.delete(options[:except]) if options[:except]
    eligible.collect { |user| user.email }
  end

  def count_solved_problems
    self.solved_problems.uniq.size
  end

  protected
  # before filter
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.blank? || !password.blank?
  end


end
