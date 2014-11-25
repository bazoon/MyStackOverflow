class AnswerPolicy < ApplicationPolicy

  def select?

    @user ? (@record.question.user == @user) && (@record.user != @user) || @user.admin : false
      

  end

end
