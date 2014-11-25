module QuestionsHelper
  include ActionView::Helpers::UrlHelper

  def active?(current_bound, bound)
    current_bound == bound ? 'active' : ''
  end

  def tag_link(tag)
    link_to tag.name, tag_search_path(tag.name), class: "label label-primary"
  end


  def vote_classes(question)
    can_vote = policy(question).vote?
    voted_up = current_user.voted_up_for?(question) if current_user
    voted_down = current_user.voted_down_for?(question) if current_user

    if can_vote
      up_class = voted_up ? "voted_up" : ""
      down_class = voted_down ? "voted_down" : ""
    else
      up_class = voted_up ? "voted_up link_disabled" : "link_disabled"
      down_class = voted_down ? "voted_down link_disabled" : "link_disabled"
    end
    

    [up_class, down_class]    
    
  end

end
