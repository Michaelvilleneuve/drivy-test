
module Days
  def nb_of_days
    (@end_date.to_time.to_i - @start_date.to_time.to_i) / 86400 + 1
  end
end