require "rails_helper"

describe UserPolicy do
  subject { UserPolicy }

  let(:user) { build_stubbed(:user) }

  context "given user's user activities" do
    permissions :index? do
      context "without user:index" do
        before(:each) { user.roles << build(:role, activities: %w(user:show)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with role:index" do
        before(:each) { user.roles << build(:role, activities: %w(user:index)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end

    permissions :show? do
      context "without user:show" do
        before(:each) { user.roles << build(:role, activities: %w(user:index)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with user:show" do
        before(:each) { user.roles << build(:role, activities: %w(user:show)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end

    permissions :new? do
      context "without user:create" do
        before(:each) { user.roles << build(:role, activities: %w(user:new)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with user:create" do
        before(:each) { user.roles << build(:role, activities: %w(user:create)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end

    permissions :create? do
      context "without user:create" do
        before(:each) { user.roles << build(:role, activities: %w(user:show)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with user:create" do
        before(:each) { user.roles << build(:role, activities: %w(user:create)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end

    permissions :edit? do
      context "without user:update" do
        before(:each) { user.roles << build(:role, activities: %w(user:show)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with user:update" do
        before(:each) { user.roles << build(:role, activities: %w(user:update)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end

    permissions :update? do
      context "without user:update" do
        before(:each) { user.roles << build(:role, activities: %w(user:show)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with user:update" do
        before(:each) { user.roles << build(:role, activities: %w(user:update)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end

    permissions :delete? do
      context "without user:delete" do
        before(:each) { user.roles << build(:role, activities: %w(user:show)) }

        it "denies" do
          should_not permit(user, user)
        end
      end

      context "with user:delete" do
        before(:each) { user.roles << build(:role, activities: %w(user:delete)) }

        it "allow" do
          should permit(user, user)
        end
      end
    end
  end
end
