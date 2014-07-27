require "active_support"

class DbInstance
  include ActiveModel::Model

  attr_accessor :db_instance_identifier, :db_instance_class, :db_name

  # FIXME this method is not need?
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) rescue nil
    end
  end


  def self.describe(db_instance_identifier = nil)

    if db_instance_identifier.blank?
      response = Hash.from_xml(get_response)
      db_instances_hash = response["DescribeDBInstancesResponse"]["DescribeDBInstancesResult"]["DBInstances"]

      db_instances = []

      db_instances_hash.each do |key, value|
        db_instance = DbInstance.new(value)
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
puts "db_instance create"
  end


  def self.delete(db_instance_identifier)
puts "db_instance delete:" + db_instance_identifier
  end


  def self.get_response(db_instance_identifier = nil)
    response = nil

    if db_instance_identifier.blank?
      # FIXME replace api_call method
      response = '<DescribeDBInstancesResponse xmlns="http://api.rdb.cloudn-service.com/"><DescribeDBInstancesResult><DBInstances><DBInstance><ReadReplicaDBInstanceIdentifiers></ReadReplicaDBInstanceIdentifiers><LatestRestorableTime/><Engine>MySQL</Engine><DBName/><PendingModifiedValues><MasterUserPassword>****</MasterUserPassword><AllocatedStorage>30</AllocatedStorage></PendingModifiedValues><BackupRetentionPeriod>1</BackupRetentionPeriod><MultiAZ>false</MultiAZ><LicenseModel>general-public-license</LicenseModel><DBInstanceStatus>available</DBInstanceStatus><EngineVersion>5.5.28</EngineVersion><Endpoint><Port>3306</Port><Address>testdb.****.example.com</Address></Endpoint><DBInstanceIdentifier>db-instance-name</DBInstanceIdentifier></DBInstance></DBInstances></DescribeDBInstancesResult><ResponseMetadata><RequestId>job-b3e443166f2e1b4c4891f221c4abbb32</RequestId></ResponseMetadata></DescribeDBInstancesResponse>'

    else

    end

    response
  end

end
