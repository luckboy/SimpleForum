class User < ActiveRecord::Base
  acts_as_authentic
  has_many :topics, :foreign_key => "author_id"
  has_many :posts, :foreign_key => "author_id"
end
