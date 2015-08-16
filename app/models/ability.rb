class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can [:index, :create, :show, :update, :destroy], Project
      can [:index, :create, :show, :update, :destroy], Document
      can [:index, :create, :show, :update, :destroy], Bookmark
      can [:index, :show, :destroy], Activity
      can [:index, :create, :show, :update, :destroy, :get_users], Role
    else
      can [:create], Project
      can [:index, :show], Project do |project|
        project.role_id == user.role_id || project.user == user
      end
      can [:update, :destroy], Project do |project|
        project.user == user
      end

      can [:index, :create, :show, :update, :destroy], Document

      can [:create], Bookmark
      can [:index, :show, :update, :destroy], Bookmark do |bookmark|
        bookmark.user == user
      end

      can [:index, :show, :destroy], Activity do |activity|
        activity.owner_id == user.id
      end
    end
  end
end
