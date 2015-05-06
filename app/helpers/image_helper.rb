module ImageHelper

  def resized_image_url(url, width, height, option = {})
    if url.match(/\/\d+-\d+\//)
      return url.gsub(/\/\d+-\d+\//, "/#{width}-#{height}#{option[:cropify]}#{option[:magnify]}#{option[:gravity]}/")
    end

    url
  end

end
