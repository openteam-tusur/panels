module EntryHelpers
  extend ActiveSupport::Concern

  private
  def flash_and_redirect(flash_text, flash_class,  symbol, render_action = false)
    flash[flash_class] = flash_text
    render_action ? render(action: symbol) : redirect_to(symbol)
  end

  def flash_and_redirect_actions(condition, action = :new, path = nil)
    p = path || :manage_entries
    if action == :new
      if condition
        flash_and_redirect "Запись добавлена", "success", p
      else
        flash_and_redirect "Ошибка в одном из полей", "alert", :new, true
      end
    else
      if condition
        flash_and_redirect "Запись отредактирована", 'success', p
      else
        flash_and_redirect "Ошибка в одном из полей", "alert", :edit, true
      end
    end
  end

end
