class Schedule

  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class} is not scheduled\n" +
         " between #{start_date} and #{end_date}"
    false
  end
end

class Bicycle
    attr_reader :schedule, :size, :chain, :tire_size
     def initialize(args={})
        @schedule = args[:schedule] || Schedule.new
        @size = args[:size]
        @chain = args[:chain] || default_chain
        @tire_size = args[:tire_size] || default_tire_size
    end

    def lead_days
        1
    end

    def schedulable?(start_date, end_date)
        !scheduled?(start_date - lead_days, end_date)
    end

    # ScheduleはBicycle内に隠れている。Bicycleを持つオブジェクトは、Scheduleのインターフェースを知らなくてもよい
    def scheduled?(start_date, end_date)
        schedule.scheduled?(self, start_date, end_date)
    end

    def default_chain
        '10-speed'
    end

    def default_tire_size
        '23'
    end
end

require 'date'
starting = Date.parse("2015/09/04")
ending = Date.parse("2015/09/10")

b = Bicycle.new
b.schedulable?(starting, ending)
