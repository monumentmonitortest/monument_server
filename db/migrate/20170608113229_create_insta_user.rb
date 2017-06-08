class CreateInstaUser < ActiveRecord::Migration[5.1]
  def change
    create_table :insta_users do |t|
      t.string :user_name
      t.string :location
      t.integer :followers_count
      t.integer :friends_count
      t.integer :post_count

      t.timestamps
    end
  end
end
