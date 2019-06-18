class Agenda
  START_TIME_OF_THE_DAY = '09:30'.freeze
  END_TIME_OF_THE_DAY = '18:00'.freeze

  attr_accessor :busy_slots

  def initialize(busy_slots)
    @busy_slots = busy_slots.map do |slot|
      Slot.new(slot[:start], slot[:end])
    end
  end

  def self.available_slots(agenda1, agenda2, duration)
    # Find free slots
    free_slots1 = agenda1.free_slots
    free_slots2 = agenda2.free_slots

    # convert slots into datetime of 1 minute
    slots_1_min = free_slots1.map { |slot| slot.time_slots_of(1) }.flatten
    slots_2_min = free_slots2.map { |slot| slot.time_slots_of(1) }.flatten

    # Find overlapping times
    intersection = slots_1_min & slots_2_min

    # Find start and end times of the overlapping times
    slots = []
    intersection[0..-2].each_with_index do |time, index|
      unless time + 1.fdiv(60 * 24) == intersection[index + 1]
        slots << time
        slots << intersection[index + 1]
      end
    end
    slots.unshift(intersection.first)
    slots.push(intersection.last)

    # convert times into slots
    result = Slot.to_slots(slots)
    available_slots = []
    result.each do |slot|
      smaller_slots = slot.time_slots_of(duration)
      smaller_slots[0..-2].each_with_index do |time, index|
        available_slots << Slot.new(time, smaller_slots[index + 1]).to_s
      end
    end
    available_slots
  end

  def free_slots
    result = []

    first_busy_slot = @busy_slots.first
    first_datetime = DateTime.parse("#{first_busy_slot.date} #{START_TIME_OF_THE_DAY}")
    first_free_slot = Slot.new(first_datetime, first_busy_slot.start)

    last_busy_slot = @busy_slots.last
    end_datetime = DateTime.parse("#{last_busy_slot.date} #{END_TIME_OF_THE_DAY}")
    last_free_slot = Slot.new(last_busy_slot.end, end_datetime)

    result << first_free_slot unless first_datetime == first_busy_slot.start

    @busy_slots[0..-2].each_with_index do |item, index|
      slot_start = item.end
      slot_end = @busy_slots[index + 1].start
      if item.date == @busy_slots[index + 1].date
        result << Slot.new(slot_start, slot_end)
      else
        slot_end = DateTime.parse("#{item.date} #{END_TIME_OF_THE_DAY}")
        result << Slot.new(slot_start, slot_end)
        slot_start = DateTime.parse("#{@busy_slots[index + 1].date} #{START_TIME_OF_THE_DAY}")
        slot_end = @busy_slots[index + 1].start
        result << Slot.new(slot_start, slot_end)
      end
    end
    result << last_free_slot unless last_busy_slot.end == end_datetime
    result
  end
end
