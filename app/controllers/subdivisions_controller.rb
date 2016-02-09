class SubdivisionsController < ApplicationController
  def collection
    render :json => DirectoryData.instance.data
  end
end
