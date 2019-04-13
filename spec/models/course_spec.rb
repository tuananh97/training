require "rails_helper"

RSpec.describe Course, type: :model do
  let(:course) {FactoryBot.create :course}
  subject {course}

  describe "Validations" do
    it "has a valid" do
      expect(course).to be_valid
    end

    it "has a invalid validate" do
      course.name = nil
      course.description = nil

      expect(course).to_not be_valid
    end
  end

  context "associations" do
    it { is_expected.to have_many :subjects }
  end
end
