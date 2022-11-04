class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def last_5_comments
    comments.last(5) # should be equivalent to => comments.order(created_at: :desc).limit(5)
  end
end
