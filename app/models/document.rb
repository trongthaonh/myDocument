class Document < ActiveRecord::Base
  belongs_to :project
  has_many :bookmarks
  has_many :users, :through => :bookmarks
end
