class InstancesController < ApplicationController

  def index
    @db_instances = DbInstance.describe

puts @db_instances.to_s
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
