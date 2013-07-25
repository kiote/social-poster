class CreateLinkedinMessages < ActiveRecord::Migration
  def change
    create_table :linkedin_messages do |t|
      t.string :text

      t.timestamps
    end
  end
end
