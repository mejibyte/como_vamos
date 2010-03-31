class Comment < ActiveRecord::Base
  attr_accessible :user_id, :commentable_id, :content, :commentable_type
  named_scope :recent, :order => "created_at DESC"
end
