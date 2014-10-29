class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    !@user.nil?
  end

  def new?
    create?
  end

  def update?
     @user && @record.user == @user || @user && @user.admin
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  # def scope
  #   Pundit.policy_scope!(user, record.class)
  # end

  # class Scope
  #   attr_reader :user, :scope

  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end

  #   def resolve
  #     scope
  #   end
  # end
end

