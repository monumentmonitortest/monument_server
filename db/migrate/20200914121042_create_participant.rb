class CreateParticipant < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.string :participant_id
      t.datetime :first_submission
    end
  end
end
