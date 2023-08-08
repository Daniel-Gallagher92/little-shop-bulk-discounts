class SwaggerService 
  
  def holiday_generator
    response = JSON.parse(connection.body)
    response.map do |holiday|
      Holiday.new(holiday)
    end
  end

  def next_three_holidays
    holiday_generator[0..2]
  end


  def connection 
    Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end

end