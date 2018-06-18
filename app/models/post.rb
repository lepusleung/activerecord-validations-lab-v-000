class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction),
    message: "%{value} is not a valid category. Please choose 'Fiction' or 'Non-Fiction'." }
  validate :clickbait_title?

  Clickbait = [/Won't Believe/, /Secret/, /Top [0-9]*/, /Guess/]

  def clickbait_title?
    if !Clickbait.detect {|w| w.match title}
      errors.add(:title, "Title must have clickbait words in it.")
    end
  end
end
