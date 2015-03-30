class InstaLog < ActiveRecord::Base
  serialize :params
  
  belongs_to :insta_user
end
