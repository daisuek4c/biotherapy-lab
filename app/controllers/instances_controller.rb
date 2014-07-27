class InstancesController < ApplicationController

  def index
    @db_instances = DbInstance.describe

    @db_instances.each do |db_instance|
puts db_instance.inspect 
    end
  end

  def show
    @db_instance = DbInstance.describe(params[:id])

  end

  def new
    @db_instance = DbInstance.new

  end

  def create
    db_instance = DbInstance.new

    db_instance.create

  end

  def destroy
    DBInstance.delete(params[:id])

  end

end
