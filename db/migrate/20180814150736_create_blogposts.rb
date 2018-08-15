class CreateBlogposts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :post
      t.timestamp :timestamp
      t.integer :user_id
    end
  end
end
