class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :text, presence: true

  after_save :update_post_comments_counter

  private

  def update_post_comments_counter
    post.increment!(:comments_counter)
  end
end
