class Project < ActiveRecord::Base
  belongs_to :user
  
  def as_json(options={})
    {
      id: self.id,
      name: self.name
    }
  end  
end
