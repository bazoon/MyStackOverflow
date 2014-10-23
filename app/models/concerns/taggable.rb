module Taggable

  module ClassMethods

    def tagged_with(tag_list)
      tag_list = tag_list.split(",").map(&:strip) if tag_list.is_a?(String)
      joins(:tags).where(tags: { name: tag_list })
    end

   end
  
  module InstanceMethods
 

    def tag_tokens
      tags.map(&:name).join(",") 
    end

    
    def tag_tokens=(tokens)

      self.tags = tokens.split(",").uniq.map do |n|
        Tag.where(name: n.strip).first_or_create!
      end
      
    end

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end