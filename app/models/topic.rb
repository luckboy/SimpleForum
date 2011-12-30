class Topic < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :forum
  has_many :posts, :order => "created_at ASC"
  
  def by_admin?
    author.admin? unless author.nil?
  end
  
  def by_mod?
    author.mod? unless author.nil?
  end
end
