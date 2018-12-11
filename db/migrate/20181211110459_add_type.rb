class AddType < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string   :name
      t.jsonb    :data
      t.integer  :submission_id
      t.timestamps
    end
  end
end
