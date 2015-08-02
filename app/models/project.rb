class Project < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
    
  belongs_to :user
  
  def as_json(options={})
    {
      id: self.id,
      name: self.name
    }
  end  
end
