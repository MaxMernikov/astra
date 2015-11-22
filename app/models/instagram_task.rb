class InstagramTask < ActiveRecord::Base
  serialize :ids_init, Array
  serialize :ids_complete, Array

end
