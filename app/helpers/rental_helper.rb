module RentalHelper
  def time_limit
    @rental.taken_at + (@rental.hours * 3600)
  end

  def remaining_time(rental)
    DateTime.now.hour - rental.taken_at.hour + rental.hours
  end
end
