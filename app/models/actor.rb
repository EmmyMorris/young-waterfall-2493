class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  validates :name, presence: true

  def self.order_by_age
    order(age: :desc)
  end
end
