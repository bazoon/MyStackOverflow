class Ability
  include CanCan::Ability

  def initialize(user)

    if user

      can :ask, Question

      can :write, Comment
      

      can :manage, Comment do |comment|
        comment.user == user
      end  

      can :manage, Question do |question|
        question.user == user 
      end

      can :destroy, Answer do |answer|
        answer.user == user
      end

      can :update, Answer do |answer|
        answer.user == user
      end

      can :select, Answer do |answer|
        answer.question.user == user
      end

      



    end

  end
end
