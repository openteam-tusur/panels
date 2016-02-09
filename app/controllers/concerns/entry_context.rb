module EntryContext
  extend ActiveSupport::Concern

  included do
    before_filter :define_contexts, :except => [:index, :show, :delete]
  end

  def define_contexts
    unless current_user.admin?
      @collection = current_user.permissions
      @label_method = -> (p) {p.context_title}
      @value_method = -> (p){p.context_id}
      @input_html  = {}
    else
      @collection = DirectoryData.instance.data
      @label_method = -> (p) {p['title']}
      @value_method = -> (p) {p['id']}
      @input_html   = { class: "js-entry-context-chosen"}
    end
  end

end
