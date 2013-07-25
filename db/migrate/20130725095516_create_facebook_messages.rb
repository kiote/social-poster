class CreateFacebookMessages < ActiveRecord::Migration
  def change
    create_table :facebook_messages do |t|
      t.string :text

      t.timestamps
    end
  end
end
