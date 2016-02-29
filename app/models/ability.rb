class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    alias_action  :new, :create, :show, :edit, :update, :destroy, :to => :crud
    can :manage, :all if user.admin?
    can :index, [Panel, Entry] if user.manager?

    can :crud, [Panel, Entry] do |model|
      manager_contexts(user).include?(model.context_id)
    end


    can :manage, Slide do |s|
      manager_contexts(user).include?(s.panel.try :context_id)
    end

    can [:create, :new], [Panel, Slide, Entry] if user.manager?

    cannot :manage, Cutaway if !user.admin?

  end

  private
  def manager_contexts(user)
    user.permissions.where(role: 'manager').map(&:context_id)
  end
end
