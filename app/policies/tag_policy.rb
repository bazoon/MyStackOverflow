class TagPolicy < Struct.new(:user, :tag)
  

  def search?
    true
  end
  
  def tags?
    false
  end

end