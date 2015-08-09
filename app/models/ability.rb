class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can [:index, :create, :show, :update, :destroy], Project
      can [:index, :create, :show, :update, :destroy, :get_users], Role
    else
      can [:create], Project
      can [:index, :show, :update, :destroy], Project do |project|
        project.user == user
      end
    end
  end
end
