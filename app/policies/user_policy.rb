class UserPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def index?
    current_user.admin?
  end

  def show?
    current_user.admin? || record.id == current_user.id
  end

  def update?
    current_user.admin? || record.id == current_user.id
  end

  def destroy?
    current_user.admin?
  end

  # Used for getting users and single user based on the role instead of wrtting if else statament in controller
  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      if current_user.admin?
        scope.all
      else
        scope.where(id: current_user.id)
      end
    end
  end
end
