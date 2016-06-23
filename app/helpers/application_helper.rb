module ApplicationHelper
  def get_formated_time(time)
    time.strftime('%m/%d/%Y')
  end
end
