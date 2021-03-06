class CreateAuthorisations < ActiveRecord::Migration
  def change
    create_table :authorisations do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
