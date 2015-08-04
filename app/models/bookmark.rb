class Bookmark < ActiveRecord::Base
  belongs_to :document
  belongs_to :user
end
