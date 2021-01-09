require 'rails_helper'

RSpec.describe Project, type: :model do

  it "is invalid without a name" do
    user = FactoryBot.create(:user)
    new_project = user.projects.create(
      name: nil,
    )

    new_project.valid?

    expect(new_project.errors[:name]).to include("can't be blank")
  end

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

  it "allows two users to share a project name" do

    user = FactoryBot.create(:user)
    user.projects.create(
      name: "Test Project",
    )

    other_user  = FactoryBot.create(:user)
    other_project = other_user.projects.build(
      name: "Test Project",
    )

    expect(other_project).to be_valid
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :project_due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :project_due_today)
      expect(project).to_not be_late
    end
    
    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :project_due_tomorrow)
      expect(project).to_not be_late
    end
  end
  
  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end
