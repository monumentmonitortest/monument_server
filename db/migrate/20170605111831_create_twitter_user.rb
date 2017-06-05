class CreateTwitterUser < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_users do |t|
      t.bigint :twitter_id
      t.string :user_name
      t.string :location
      t.integer :followers_count
      t.integer :friends_count

      t.timestamps
    end
  end
end
