class Document < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  before_save :save_filename
  belongs_to :project
  has_many :bookmarks
  has_many :users, :through => :bookmarks
  mount_uploader :file, FileUploader

  private
    def save_filename
      write_attribute :filename, self.file.filename
    end
end
