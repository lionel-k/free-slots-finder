class Slot
  SECOND = 1
  MINUTE = 60 * SECOND
  HOUR = 60 * MINUTE
  DAY = 24 * HOUR

  attr_reader :start, :end

  def initialize(start_datetime, end_datetime)
    @start = start_datetime
    @end = end_datetime
  end

  def date
    @start.strftime('%d/%m/%Y')
  end

  def time_slots_of(duration)
    number = ((@end - @start) * DAY).to_i / (duration * MINUTE)
    new_start = @start
    res = [@start]
    number.to_i.times do
      new_start += duration.fdiv(DAY / MINUTE)
      res << new_start
    end
    res
  end

  def self.to_slots(times)
    result = []
    times.each_slice(2) do |start_time, end_time|
      result << Slot.new(start_time, end_time)
    end
    result
  end

  def to_s
    {
      start: @start,
      end: @end
    }
  end
end
