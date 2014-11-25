module ApplicationHelper


  def ld(d)
    I18n.l(d, format: :long) unless d.nil?
  end  


  def show_icon
    content_tag(:span,"",class: "glyphicon glyphicon-folder-open")
  end

  def edit_icon
    content_tag(:span,"",class: "glyphicon glyphicon-edit")
  end

  def del_icon
    content_tag(:span,"",class: "glyphicon glyphicon-trash", alt: "delete")
  end


  def red_label(s)
    content_tag(:span,s,class: "label label-danger")
  end

  def green_label(s)
    content_tag(:span,s,class: "label label-success")
  end


  def users_icon
    content_tag(:span,"",class: "glyphicon glyphicon-user")
  end

  def select_icon
    content_tag(:span,"",class: "glyphicon glyphicon-star")
  end


  def vote_up_icon
    content_tag(:i,"",class: "fa fa-sort-asc fa-3x")
  end

  def vote_down_icon
    content_tag(:i,"",class: "fa fa-sort-desc fa-3x")
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction
  end

  
  def now
    Time.zone.now
  end


end
