class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  attr_accessible :comment, :user_id
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  belongs_to :user

  def time
    ((Time.now() - self.created_at) / 3600.0).round(1)
  end
end
