SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    #primary.item :main_page,      I18n.t('page_title.application.index'), root_path
    #if current_user && current_user.has_permission?(role: 'admin')
      #primary.item :admin_dashboard, I18n.t('page_title.admin_dashboard.index'), rails_admin.dashboard_path
    #end
  end
end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
