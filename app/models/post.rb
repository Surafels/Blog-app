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
end
