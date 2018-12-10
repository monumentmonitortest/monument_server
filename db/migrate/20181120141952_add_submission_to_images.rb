class AddSubmissionToImages < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :images, :submission
  end

  def self.down
    remove_attachment :images, :submission
  end
end
