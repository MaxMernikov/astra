class InstaCache < ActiveRecord::Base
  serialize :info_hash
  
  belongs_to :insta_user
end
