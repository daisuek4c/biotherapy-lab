class PendingModifiedValue
  include ActiveModel::Model

  attr_accessor :allocated_storage, :backup_retention_period, :db_instance_class, :engine_version, :master_user_password, :multi_az, :port

end
