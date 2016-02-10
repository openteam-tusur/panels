module ContextMethods
  extend ActiveSupport::Concern

  included do
    scope :with_context, -> (context_ids_list) { where(context_id: context_ids_list) }
  end

  def context_title
    DirectoryData.instance.get_title(context_id || "")
  end

end
