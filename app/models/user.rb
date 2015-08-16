class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :lockable

  has_many :projects
  belongs_to :role
  has_many :bookmarks
  has_many :documents, :through => :bookmarks

  serialize :shared_with_me, Array

  def as_json(options={})
    {
      id: self.id,
      email: self.email
    }
  end  
end
