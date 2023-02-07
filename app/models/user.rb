class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :name, presence: true, length: { in: 3..25 }
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end

  def last_3_posts
    posts.last(3) # should be equivalent to => posts.order(created_at: :desc).limit(3)
  end
end
