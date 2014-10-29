class Tag < ActiveRecord::Base
  has_many :taggings
  validates :name, presence: true

  def self.find_or_new(name)
    tags = where('name like ? or name like ? or name like ?', "%#{name}%", "%#{name}%", "%#{name}%")
    tags = tags.map { |tag| { id: tag.name, name: tag.name } }
    tags = [id: "#{name}", name: "New: #{name}"] if tags.empty?
    tags
  end


end
