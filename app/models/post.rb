class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_user_posts_counter
    user.update(post_counter: user.post.count)
  end

  def recent_comments
    comments.order(commented_at: desc).limit(5)
  end
end
