require "active_support"

class DbInstance < AbstractModel


  attr_accessor :allocated_storage, :auto_minor_version_upgrade, :availability_zone, :backup_retention_period, :character_set_name,
                :cloudn_paas_link_status, :db_instance_class, :db_instance_identifier, :db_instance_status, :db_name,
                :endpoint, :engine, :engine_version, :instance_create_time, :lastest_restoreable_time,
                :license_model, :master_user_name, :multi_az, :preferred_backup_window, :preferre_maintenance_window,
                :read_replica_db_instance_identifier, :read_replica_source_db_instance_identifier


  def self.describe(db_instance_identifier = nil)

    if db_instance_identifier.blank?
      response = Hash.from_xml(get_response)
      db_instances_hash = response["DescribeDBInstancesResponse"]["DescribeDBInstancesResult"]["DBInstances"]["DBInstance"]

      db_instances = []

      if db_instances_hash.is_a?(Array)
        db_instances_hash.each do |element|
          db_instance = DbInstance.new(convert(element))
          db_instances.push(db_instance)
        end

      else
        db_instance = DbInstance.new(convert(db_instances_hash))
        db_instances.push(db_instance)
      end

      return db_instances

    else
      response = Hash.from_xml(get_response(db_instance_identifier))
      db_instance_hash = response["DescribeDBInstancesResponse"]["DescribeDBInstancesResult"]["DBInstances"]["DBInstance"]

      DbInstance.new(db_instance_hash)

      return db_instance

    end

  end


  def create
  end


  def self.delete(db_instance_identifier)
  end


  def self.convert(hash)
    converted = {}

    hash.each do |key, value|
      if value.is_a?(Hash)
        value = convert(value)
      end
      converted[key.underscore] = value
    end

    converted
#    converted.symbolize_keys
  end


  def self.get_response(db_instance_identifier = nil)
    response = nil

    # FIXME replace api_call method
    response = '<DescribeDBInstancesResponse xmlns="http://api.rdb.cloudn-service.com/"><DescribeDBInstancesResult><DBInstances>'
    element = '<DBInstance><ReadReplicaDBInstanceIdentifiers></ReadReplicaDBInstanceIdentifiers><LatestRestorableTime/><Engine>MySQL</Engine><DBName/><PendingModifiedValues><MasterUserPassword>****</MasterUserPassword><AllocatedStorage>30</AllocatedStorage></PendingModifiedValues><BackupRetentionPeriod>1</BackupRetentionPeriod><MultiAZ>false</MultiAZ><LicenseModel>general-public-license</LicenseModel><DBInstanceStatus>available</DBInstanceStatus><EngineVersion>5.5.28</EngineVersion><Endpoint><Port>3306</Port><Address>testdb.****.example.com</Address></Endpoint><DBInstanceIdentifier>db-instance-name</DBInstanceIdentifier></DBInstance>'
    response += element
    response += element
    response += '</DBInstances></DescribeDBInstancesResult><ResponseMetadata><RequestId>job-b3e443166f2e1b4c4891f221c4abbb32</RequestId></ResponseMetadata></DescribeDBInstancesResponse>'

    response
  end

end
