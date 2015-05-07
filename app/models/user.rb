class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name'].to_s.parameterize('_')
  end
end
