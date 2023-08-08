class Holiday
  attr_reader :name, :date

  def initialize(holidata)
    @name = holidata["localName"]
    @date = holidata["date"].to_date.strftime("%A, %B %-e, %Y")
  end
end