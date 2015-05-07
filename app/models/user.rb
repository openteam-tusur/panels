class User
  include AuthClient::User

  def app_name
    Settings['app.name'].to_s.parameterize('_')
  end
end
