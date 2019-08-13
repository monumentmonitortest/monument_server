class AddTypeSpecificIdToType < ActiveRecord::Migration[5.2]
  def change
    add_column :types, :type_specific_id, :string
    add_column :types, :comment, :text
  end
end
