class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  scope :top_posts, -> {
    joins(:reviews)
      .group('posts.id')
      .select('posts.*, AVG(reviews.rating) AS average_rating')
      .order('average_rating DESC')
  }
end
