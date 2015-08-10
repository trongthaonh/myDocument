class Bookmark < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  belongs_to :document
  belongs_to :user
end
