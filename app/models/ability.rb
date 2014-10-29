class Ability
  include CanCan::Ability

  def initialize(user)

    if user

      can :ask, Question

      can :write, Comment
      

      can :manage, Comment do |comment|
        comment.user == user
      end

      can :destroy, Question do |question|
        question.user == user
      end

      can :edit, Question do |question|
        question.user == user
      end

      can :update, Question do |question|
        question.user == user
      end

      can :rate, Question do |question|
        question.user != user && !Vote.voted?(question, user)
      end

      can :rate, Answer do |answer|
        answer.user != user && !Vote.voted?(answer, user)
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
