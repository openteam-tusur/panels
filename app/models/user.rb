class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name'].to_s.parameterize('_')
  end

  def entries
    return Entry.except_cutaways.ordered if admin?

    Entry.except_cutaways.with_context(context_ids).ordered
  end

  def panels
    return Panel.all if admin?

    Panel.with_context(context_ids)
  end

  def context_ids
    permissions.pluck(:context_id)
  end

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      has_permission? role: role
    end
  end
end
