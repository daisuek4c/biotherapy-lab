class AbstractModel
  include ActiveModel::Model


  def initialize(attributes = {})

    attributes.stringify_keys.each do |key, value|
      if value.is_a?(Hash)
        value = key.classify.constantize.new(value)
      end
      send("#{key}=", value) rescue nil

    end

  end


end

