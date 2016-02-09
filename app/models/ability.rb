class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    can :manage, :all if user.admin?

    can :manage, [Panel, Slide, Entry] do |model|
      manager_contexts(user).include?(model.context_id)
    end

    can :create, [Panel, Slide, Entry] if user.manager?
  end

  private
  def manager_contexts(user)
    user.permissions.where(role: 'manager').map(&:context_id)
  end
end
