module ApplicationHelper
  def get_formated_time(time)
    time.strftime('%m/%d/%y')
  end
end
