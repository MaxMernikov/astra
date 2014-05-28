class Ability
  include CanCan::Ability

  def initialize(admin)
    admin ||= Admin.new

    if admin.persisted?
      can :manage, :all
    end
  end
end