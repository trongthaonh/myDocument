class Project < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
    
  belongs_to :user
  belongs_to :role
  has_many :documents

  def as_json(options={})
    {
      id: self.id,
      name: self.name
    }
  end  
end
