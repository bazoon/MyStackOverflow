ThinkingSphinx::Index.define :user, with: :active_record do 

  #fields
  indexes email, sortable: true
  indexes name, sortable: true
  
  #attributes
  has created_at, updated_at

  
end