class User < ActiveRecord::Base
      has_many :blogposts
end
