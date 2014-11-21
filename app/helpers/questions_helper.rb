module QuestionsHelper
  include ActionView::Helpers::UrlHelper

  def active?(current_bound, bound)
    current_bound == bound ? 'active' : ''
  end

  def tag_link(tag)
    link_to tag.name, tag_search_path(tag.name), class: "label label-default"
  end

end
