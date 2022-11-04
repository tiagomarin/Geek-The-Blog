class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  def last_3_posts
    posts.last(3) # should be equivalent to => posts.order(created_at: :desc).limit(3)
  end
end
