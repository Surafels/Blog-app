class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_user_comment_counter
  def update_user_comment_counter
    user.update(comment_counter: post.comments.count)
  end
end
