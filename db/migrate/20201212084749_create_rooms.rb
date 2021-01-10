class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer :tweet_id
      t.integer :owner_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
