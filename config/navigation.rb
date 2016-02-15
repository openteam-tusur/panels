SimpleNavigation::Configuration.run do |navigation|

  navigation.selected_class = 'active'

  navigation.items do |primary|

    primary.item :main_page, I18n.t('page_title.application.index'), root_path

    primary.item :manage_panels, 'Управление панелями', manage_panels_path,
      :highlights_on => /^\/manage\/panels/ if can? :manage, Panel

    primary.item :manage_entries, 'Управление объявлениями', manage_entries_path,
      :highlights_on => /^\/manage\/(entries|texts|photos|videos)/ if can? :manage, Entry

    primary.item :manage_entries, 'Управление перебивками', manage_cutaways_path,
      :highlights_on => /^\/manage\/(cutaways)/ if can? :manage, Cutaway

    primary.item :manage_permissions, 'Управление правами', manage_permissions_path,
      :highlights_on => /^\/manage\/permissions/ if can? :manage, Permission

    primary.item :manage_service, 'Сервис', manage_services_path,
      :highlights_on => /^\/manage\/services/ if current_user && current_user.admin?

    primary.item :documentation, 'Как пользоваться системой?', documentation_path

  end

end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
