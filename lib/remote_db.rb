class RemoteDB < ActiveRecord::Base

  establish_connection(:remote_db)
  self.abstract_class = true

end
