require "rails_helper"

describe RolePolicy do
  subject { RolePolicy }

  let(:role) { build_stubbed(:role) }
  let(:user) { build_stubbed(:user) }

  context "given user's role activities" do
    permissions :index? do
      context "without role:index" do
        before(:each) { user.roles << build(:role, activities: %w(role:show)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:index" do
        before(:each) { user.roles << build(:role, activities: %w(role:index)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end

    permissions :show? do
      context "without role:show" do
        before(:each) { user.roles << build(:role, activities: %w(role:index)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:show" do
        before(:each) { user.roles << build(:role, activities: %w(role:show)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end

    permissions :new? do
      context "without role:create" do
        before(:each) { user.roles << build(:role, activities: %w(role:new)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:create" do
        before(:each) { user.roles << build(:role, activities: %w(role:create)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end

    permissions :create? do
      context "without role:create" do
        before(:each) { user.roles << build(:role, activities: %w(role:show)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:create" do
        before(:each) { user.roles << build(:role, activities: %w(role:create)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end

    permissions :edit? do
      context "without role:update" do
        before(:each) { user.roles << build(:role, activities: %w(role:show)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:update" do
        before(:each) { user.roles << build(:role, activities: %w(role:update)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end

    permissions :update? do
      context "without role:update" do
        before(:each) { user.roles << build(:role, activities: %w(role:show)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:update" do
        before(:each) { user.roles << build(:role, activities: %w(role:update)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end

    permissions :delete? do
      context "without role:delete" do
        before(:each) { user.roles << build(:role, activities: %w(role:show)) }

        it "denies" do
          should_not permit(user, role)
        end
      end

      context "with role:delete" do
        before(:each) { user.roles << build(:role, activities: %w(role:delete)) }

        it "allow" do
          should permit(user, role)
        end
      end
    end
  end
end
