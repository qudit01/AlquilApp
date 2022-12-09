class FeedBack < ApplicationRecord
  belongs_to :user
  belongs_to :rental
  belongs_to :car

  enum score: { bad: 1, medium_bad: 2, medium: 3, medium_good: 4, good: 5 }
  validates :score, presence: true, inclusion: { in: scores.keys }
end
