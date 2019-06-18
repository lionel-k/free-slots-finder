require 'date'

require 'slot'
require 'agenda'

describe 'agenda' do
  let(:sandra_busy_slots) do
    [
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
        end: DateTime.new(2019, 6, 20, 17, 55)
      },
      {
        start: DateTime.new(2019, 6, 21, 11, 0),
        end: DateTime.new(2019, 6, 21, 17, 30)
      }
    ]
  end

  let(:andrew_busy_slots) do
    [
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
        end: DateTime.new(2019, 6, 20, 17, 58)
      },
      {
        start: DateTime.new(2019, 6, 21, 10, 50),
        end: DateTime.new(2019, 6, 21, 17, 55)
      }
    ]
  end

  it 'should finds available slots of 1 hour' do
    agenda1 = Agenda.new(sandra_busy_slots)
    agenda2 = Agenda.new(andrew_busy_slots)

    result = [
      {
        start: DateTime.new(2019, 6, 20, 15, 0),
        end: DateTime.new(2019, 6, 20, 16, 0)
      },
      {
        start: DateTime.new(2019, 6, 20, 16, 0),
        end: DateTime.new(2019, 6, 20, 17, 0)
      },
      {
        start: DateTime.new(2019, 6, 21, 9, 30),
        end: DateTime.new(2019, 6, 21, 10, 30)
      }
    ]

    expect(Agenda.available_slots(agenda1, agenda2, 60)).to eq(result)
  end
end
