require 'capybara/rails'

module CalendarHelpers

  def select_future_commit_date
    find("#event_commit_date").click
    find(".picker--opened .picker__nav--next").click
    page.all(".picker--opened .picker__day.picker__day--infocus")[0].click
  end

end
