class Comment < ActiveRecord::Base
  include Voteable
  validates :body, presence: true
  belongs_to :post
  belongs_to :user
  #has_many :votes, as: :voteable

end
