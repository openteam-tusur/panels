class IntegrationController < ApplicationController
  require 'rest-client'

  def time_and_week
    url = "#{Settings['timetable.url']}/api/v1/current_week_parity"
    result = JSON.parse(RestClient.get url)
    result["current_week"] = result["current_week"] == 'odd' ? 'Нечётная' : 'Чётная'
    result[:date] = I18n.l(Time.zone.now, :format => '%d %B %Y')
    result[:time] = I18n.l(Time.zone.now, :format => '%H:%M')
    render :json => result
  end

end
