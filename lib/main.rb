require 'date'

require_relative 'slot'
require_relative 'agenda'

SLOT_DURATION = 60

sandra_busy_slots = [
  {
    start: DateTime.new(2019, 6, 20, 9, 30),
    end: DateTime.new(2019, 6, 20, 9, 40)
  },
  {
    start: DateTime.new(2019, 6, 20, 10, 0),
    end: DateTime.new(2019, 6, 20, 11, 0)
  },
  {
    start: DateTime.new(2019, 6, 20, 12, 0),
    end: DateTime.new(2019, 6, 20, 14, 30)
  },
  {
    start: DateTime.new(2019, 6, 20, 17, 45),
    end: DateTime.new(2019, 6, 20, 18, 0)
  }
]

andrew_busy_slots = [
  {
    start: DateTime.new(2019, 6, 20, 10, 30),
    end: DateTime.new(2019, 6, 20, 10, 45)
  },
  {
    start: DateTime.new(2019, 6, 20, 11, 30),
    end: DateTime.new(2019, 6, 20, 15, 0)
  },
  {
    start: DateTime.new(2019, 6, 20, 17, 0),
    end: DateTime.new(2019, 6, 20, 18, 0)
  }
]

agenda1 = Agenda.new(sandra_busy_slots)
agenda2 = Agenda.new(andrew_busy_slots)

p Agenda.available_slots(agenda1, agenda2, SLOT_DURATION)
