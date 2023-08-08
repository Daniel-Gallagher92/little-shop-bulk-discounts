require 'rails_helper'

RSpec.describe SwaggerService do 

  it "can establish connection" do 
    response = SwaggerService.new.connection
    parsed_body = JSON.parse(response.body)
    expect(parsed_body).to be_an(Array)
    expect(parsed_body).to all be_a(Hash)
    expect(parsed_body.first).to have_key("name")
    expect(parsed_body.first).to have_key("date")
  end

  it "can generate holidays" do 
    holidays = SwaggerService.new.holiday_generator
    expect(holidays).to be_an(Array)
    expect(holidays).to all be_a(Holiday)
  end

  it "can generate next three holidays" do
    holidays = SwaggerService.new.next_three_holidays
    expect(holidays.count).to eq(3)
    dates = holidays.map do |holiday|
      holiday.date.to_date
    end

    expect(Date.today).to be < dates.first
    expect(Date.today < dates[0]).to be true
    expect(dates[1] < dates[2]).to be true
  end
end