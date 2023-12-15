class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_create :update_user_posts_counter
  def update_user_posts_counter
    author.update(post_counter: author.post.count)
  end

  def recent_comments
    comments.order(commented_at: desc).limit(5)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
