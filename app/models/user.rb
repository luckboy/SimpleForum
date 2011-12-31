class User < ActiveRecord::Base
  acts_as_authentic
  has_many :topics, :foreign_key => "author_id", :dependent => :nullify
  has_many :posts, :foreign_key => "author_id", :dependent => :nullify
  
  def admin?
    is_admin
  end
  
  def mod?
    is_mod
  end
end
