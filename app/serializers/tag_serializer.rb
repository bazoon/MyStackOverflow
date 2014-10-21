class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :url


  def url
    "/tags/search/#{object.name}"
  end

end
