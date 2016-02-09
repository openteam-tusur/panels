module ContextMethods
  extend ActiveSupport::Concern

  def context_title
    DirectoryData.instance.get_title(context_id || "")
  end

end
