class Post < ActiveRecord::Base
  include Voteable 
  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  #has_many :votes, as: :voteable
  before_save :generate_slug

  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
  end
  
  def to_param
    self.slug
  end
end

