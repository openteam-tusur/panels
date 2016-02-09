class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name'].to_s.parameterize('_')
  end

  def entries
    return Entry.all.where.not(type: 'Cutaway').order('id desc') if admin?
    permissions.flat_map{|p| Entry.all.where.not(type: 'Cutaway').where(context_id: p.context_id ).order('id desc')}
  end

  def panels
    return Panel.all if admin?
    permissions.flat_map{|p| Panel.where(context_id: p.context_id)}
  end

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      has_permission? role: role
    end
  end
end
