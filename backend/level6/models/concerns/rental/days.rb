module Days
  def nb_of_days
    (@end_date - @start_date).to_i + 1
  end
end