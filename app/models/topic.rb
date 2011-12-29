class Topic < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :forum
  has_many :posts, :order => "created_at ASC"
end
