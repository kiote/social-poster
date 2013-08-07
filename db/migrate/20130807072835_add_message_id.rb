class AddMessageId < ActiveRecord::Migration
  def change
    add_column :facebook_messages, :message_id, :integer
    add_index :facebook_messages, :message_id

    add_column :linkedin_messages, :message_id, :integer
    add_index :linkedin_messages, :message_id    

    add_column :tumblr_messages, :message_id, :integer
    add_index :tumblr_messages, :message_id   

    add_column :twitter_messages, :message_id, :integer
    add_index :twitter_messages, :message_id   

    add_column :vkontakte_messages, :message_id, :integer
    add_index :vkontakte_messages, :message_id   
  end
end
