require "rails_helper"

describe Permission do
  it "should be able to create" do
    expect(create :permission, :admin  ).to be_truthy
  end

  it "should have context, if role is a manager " do
    permission = build :permission, role: :manager
    expect(permission.valid?).to be false
    expect(permission.errors.messages.keys.include? :context).to be true
  end

end
