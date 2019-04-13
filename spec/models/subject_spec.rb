require "rails_helper"

RSpec.describe Subject, type: :model do
  let!(:course) {FactoryBot.create :course}

  context "validates" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }
  end

  context "associations" do
    it { is_expected.to have_many :tasks }
    it { is_expected.to belong_to :course }
  end
end
