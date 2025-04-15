class DietPlanPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def create?
    current_user.admin?
  end

  def destroy?
    current_user.admin?
  end

  def show?
    current_user.admin? || record.user_id == current_user.id
  end

  def update?
    current_user.admin? || record.user_id == current_user.id
  end
end

