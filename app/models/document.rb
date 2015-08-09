class Document < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  before_save :save_filename
  belongs_to :project
  has_many :bookmarks
  has_many :users, :through => :bookmarks
  mount_uploader :file, FileUploader

  scope :get_by_tags, -> (tag) {
    where("lower(tag) LIKE ?", "%#{tag.downcase}%" ) 
  }

  scope :get_by_comment, -> (comment) {
    where("lower(comment) LIKE ?", "%#{comment.downcase}%" ) 
  }  

  scope :get_by_content, -> (content) {
    where("lower(content) LIKE ?", "%#{content.downcase}%" ) 
  } 

  scope :get_by_period_of_time, -> (start_date, end_date) {
    where("created_at >= ? AND created_at <= ?", start_date, end_date) 
  }

  def self.search(params = {})

    documents = Document.all
    documents = documents.get_by_tags(params[:tag]) if params[:tag]
    @documents = @documents.get_by_comment(params[:comment]) if params[:comment]
    @documents = @documents.get_by_content(params[:content]) if params[:content]

    @documents = if params[:start_date] && params[:start_date]
      @documents.get_by_period_of_time(params[:start_date], params[:end_date])
    end

    documents
  end

  def self.as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  private
    def save_filename
      write_attribute :filename, self.file.filename
    end
end
