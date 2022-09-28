class Movie < ApplicationRecord
  RATINGS = %w(G PG PG-13 R NC-17)
  # Validation rules
  validates :title, :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }
 
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  validates :rating, inclusion: { in: RATINGS }
  # Class Methods
  def self.released
    Movie.where("released_on < ?", Time.now).order(relased_on: :desc)
  end

  # Logic
  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

end
