module Taggable
  

  module ClassMethods
    
    def tagged_with(tag_list)
      self.includes(:tags).joins(:tags).where(tags: { name: tag_list } )
    end

  end
  
  module InstanceMethods
  
    def tag_list=(tag_list)
      taggings.delete_all

      tag_list.split(',').each do |t|
        tag = Tag.where(name: t).first_or_create
        taggings.where(tag: tag, taggable_id: self, taggable_type: self.class.to_s).first_or_create
      end
    end

    def tag_list
      tags.map(&:name).join(",")
    end

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end