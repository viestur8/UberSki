class CreateTaggedPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :tagged_posts do |t|
      t.integer :tag_id
      t.integer :post_id
    end
  end
end
