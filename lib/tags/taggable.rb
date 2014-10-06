module Taggable
  

  module ClassMethods
    
    def tagged_with(tag_list)
      includes(:tags).joins(:tags).where(tags: { name: tag_list })
    end

  end
  
  module InstanceMethods
  
    def tag_list=(names)
      self.tags = names.split(",").map do |n|
        Tag.where(name: n.strip).first_or_create!
      end
    end
    
    # def tag_list=(tag_list)
  

    #   self.tags = tag_list.split(',').map do |t|
    #     Tag.where(name: t.strip).first_or_create!
    #   end
    #   binding.pry
    # end

    def tag_list
      tags.map(&:name).join(",")
    end

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end