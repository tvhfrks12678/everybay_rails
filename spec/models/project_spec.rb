require 'rails_helper'

RSpec.describe Project, type: :model do

  it "is invalid without a name" do
    user = User.create(
      first_name: "Joe",
      last_name: "yTester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    new_project = user.projects.create(
      name: nil,
    )

    new_project.valid?

    expect(new_project.errors[:name]).to include("can't be blank")
  end



  it "does not allow duplicate project names per user" do

    user = User.create(
      first_name: "Joe",
      last_name: "yTester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(
      name: "Test Project",
    )

    new_project = user.projects.build(
      name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include
  end

  it "allows two users to share a project name" do
    user = User.create(
      first_name: "Jae",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(
      name: "Test Project",
    )

    other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email: "jaetester@example.com",
      password: "dottle-nouveau-pavilion-tight-furze",
    )

    other_project = other_user.projects.build(
      name: "Test Project",
    )

    expect(other_project).to be_valid
  end
end

#p34 まで
