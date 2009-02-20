require "time"

class RestZeit
  def initialize finish, start_time, end_time
    @finish= Time.parse(finish)
    @start_time= Time.parse(start_time)
    @end_time= Time.parse(end_time)
    @work_hours= duration_in_hours(@end_time-@start_time)
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
    @days += 1 if duration_in_hours(@start_time-@now)>0
    @days
  end
  def time
    return @time unless @time.nil?
    todays_hours= duration_in_hours(@end_time-@now)
    last_hours= duration_in_hours(@finish-@start_time)
    
    if todays_hours<0 || todays_hours>@work_hours
      @time= 0
    else
      @time= ((todays_hours+last_hours)%(@work_hours))
    end
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
  
  private
  def duration_in_hours duration
    ((duration)%(24*60*60))/(60*60)
  end
end

#r= RestZeit.new("01.29 18:30", "09:30", "18:30")
#puts r.text
