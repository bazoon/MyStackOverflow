module ApiMacros
  

  def check_json(object, attr, path)
    expect(response.body).to be_json_eql(object.send(attr.to_sym).to_json).at_path(path)   
  end   

end