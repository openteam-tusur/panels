class DirectoryData
  include Singleton

  def data
    get_data if check_last_update || !defined? @data
    @data
  end

  def get_title(id)
    puts id
    res = data.select{|s| s['id'] == id }.first
    res.nil? ? res : res["title"]
  end

  private

  def get_data
    url =  (Settings["directory.subdivisions_url"])
    begin
    @data = JSON.parse(open(URI.encode(url)).read)
    @last_update_time = Time.zone.now
    rescue
      get_data
    end
  end

  def check_last_update
    @last_update_time.nil? || Time.zone.now - 1.day > @last_update_time ? true : false
  end

end
