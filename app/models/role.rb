class Role < ActiveRecord::Base
  has_many :users
  has_many :projects

  def as_json(options={})
    {
      id: self.id,
      name: self.name
    }
  end    
end
