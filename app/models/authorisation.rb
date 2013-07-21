class Authorisation < ActiveRecord::Base  
  
  belongs_to :user
  
  validates :provider, :uid, presence: true
  validates :user_id, uniqueness: {scope: [:provider, :uid]}
  
end
