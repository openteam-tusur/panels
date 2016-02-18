class IntegrationController < ApplicationController
  require 'rest-client'

  def datetime
    result = {}
    result[:date] = I18n.l(Time.zone.now, :format => '%d %B %Y')
    result[:time] = I18n.l(Time.zone.now, :format => '%H:%M')
    render :json => result
  end

  def week
    rest_response ||= RestClient::Request.execute(
      method: :get,
      url: "#{Settings['timetable.url']}/api/v1/current_week_parity",
      timeout: nil,
      payload: nil,
      headers: { Accept: nil }
    ) do |response, request, result, &block|
      response
    end
    result = JSON.load(rest_response.body) rescue {}
    result['week'] = 'Нечётная' if result['current_week'] == 'odd'
    result['week'] = 'Чётная' if result['current_week'] == 'even'
    render :json => result
  end

end
