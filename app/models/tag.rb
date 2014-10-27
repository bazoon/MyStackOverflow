class Tag < ActiveRecord::Base
  has_many :taggings
  validates :name, presence: true


  def find_or_new(name)
    tags = where(name: name)
    tags = tags.map { |tag| { id: tag.name, name: tag.name } }
    tags = [id: "#{name}", name: "New: #{name}"] if tags.empty?
  end

end
