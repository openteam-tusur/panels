class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    can :manage, :all if user.admin?

    can :manage, [Panel, Entry] do |model|
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
