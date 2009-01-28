require "time"

class RestZeit
  def initialize finish, start_time, end_time
    @finish= Time.parse(finish)
    @start_time= Time.parse(start_time)
    @end_time= Time.parse(end_time)
    @work_hours= ((@end_time-@start_time)%(24*60*60))/(60*60)
    update
  end
  def update
    @now= Time.now
    @days= nil
    @time= nil
  end
  def left
    @finish-@now
  end
  def days
    return @days unless @days.nil?
    @days=0
    stepper= @now
    while(@finish-stepper>(24*60*60))
      stepper+= (24*60*60)
      @days += 1 if (1..5)===stepper.wday
    end
    @days
  end
  def time
    return @time unless @time.nil?
    todays_hours= ((@end_time-@now)%(24*60*60))/(60*60)
    last_hours= ((@finish-@start_time)%(24*60*60))/(60*60)
    
    @time= ((todays_hours+last_hours)%(@work_hours))
  end
  def hours
    time.floor
  end
  def minutes
    ((time-hours)*60).floor
  end
  def seconds
    ((((time-hours)*60)-minutes)*60).floor
  end

  def text
    "#{days} Tage, #{sprintf("%02d",hours)}:#{sprintf("%02d",minutes)}:#{sprintf("%02d",seconds)}"
  end
end

#r= RestZeit.new("01.29 18:30", "09:30", "18:30")
#puts r.text
