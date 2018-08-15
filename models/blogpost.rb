class Post < ActiveRecord::Base
    belongs_to :user
    has_many :tagged_posts
    has_many :tags, through: :tagged_posts
end
