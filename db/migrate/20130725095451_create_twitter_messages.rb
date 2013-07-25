class CreateTwitterMessages < ActiveRecord::Migration
  def change
    create_table :twitter_messages do |t|
      t.string :text

      t.timestamps
    end
  end
end
