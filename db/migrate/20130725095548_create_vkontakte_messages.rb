class CreateVkontakteMessages < ActiveRecord::Migration
  def change
    create_table :vkontakte_messages do |t|
      t.string :text

      t.timestamps
    end
  end
end
