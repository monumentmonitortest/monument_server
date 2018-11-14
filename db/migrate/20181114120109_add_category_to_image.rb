class AddCategoryToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :category, :string
  end
end
