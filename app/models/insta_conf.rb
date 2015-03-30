class InstaConf < ActiveRecord::Base
  serialize :settings_response
  serialize :info_response
end
