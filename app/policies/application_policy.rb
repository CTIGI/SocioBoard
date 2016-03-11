class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def user_activities
    @user.roles.select(:activities).distinct.map(&:activities).flatten
  end

  def is_admin?
    user_activities.include?("admin:admin")
  end

  def is_resource_admin?
    user_activities.include?("#{@record.class.name.downcase}:admin")
  end

  def inferred_activity(method)
    "#{@record.class.name.underscore}:#{method}"
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    delete?
  end

  def show_menu?
    menu_permissions = user_activities.map { |ua| ua.split(":")[0] }
    menu_permissions.include?(record.name.underscore) || is_admin?
  end

  def show_item_menu?(role)
    user_activities.include?(role) || is_admin?
  end

  def method_missing(name,*args)
    if name.to_s.last == "?"
      user_activities.include?(inferred_activity(name.to_s.gsub('?',''))) || is_admin? || user_activities.include?("#{@record.class.name.downcase}:admin")
    else
      super
    end
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
