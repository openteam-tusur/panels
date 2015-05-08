SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :main_page, I18n.t('page_title.application.index'), root_path

    primary.item :manage_panels, 'Управление панелями', manage_panels_path if can? :manage, Panel
    primary.item :manage_entries, 'Управление объявлениями', manage_entries_path if can? :manage, Entry
  end
end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
