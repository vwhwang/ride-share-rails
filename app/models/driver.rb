class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    total_rating = 0.00
    count = 0
    self.trips.each do |trip|
      if trip.rating
        total_rating += trip.rating
        count += 1
      end
    end
    return (total_rating / count).round(2)
  end

  def total_earning
    total = 0
    count = 0
    self.trips.each do |trip|
      total += trip.cost
      count += 1
    end
    result = ((total - (1.65 * count)) * 0.8).round(2)
    return result
  end

end
