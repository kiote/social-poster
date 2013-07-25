class CreateTumblrMessages < ActiveRecord::Migration
  def change
    create_table :tumblr_messages do |t|
      t.string :text

      t.timestamps
    end
  end
end
