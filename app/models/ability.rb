class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can [:index, :create, :show, :update, :destroy], Project
    else
      can [:show, :update, :destroy], Project do |project|
        project.user == user
      end
    end
  end
end
