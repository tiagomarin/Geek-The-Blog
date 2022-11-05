class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true, length: { in: 3..25 }
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_3_posts
    posts.last(3) # should be equivalent to => posts.order(created_at: :desc).limit(3)
  end
end
