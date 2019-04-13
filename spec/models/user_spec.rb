require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  subject {user}

  describe "validation" do
    it "has a valid" do
      expect(user).to be_valid
    end

    it "has a invalid validate" do
      user.email = nil
      user.password = nil
      expect(user).to_not be_valid
    end

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  context "when email is not valid" do
    before {subject.email = ""}
    it { is_expected.not_to be_valid }
  end

  describe "length validation" do
    context "validates length of name" do
      it {should_not allow_value("ab").for :name}
      it {should_not allow_value("a"*126).for :name}
      it {should allow_value("abc").for :name}
    end

    context "validates length of phone" do
      it {should_not allow_value("avcd").for :phone}
      it {should_not allow_value("").for :phone}
      it {should_not allow_value("2"*26).for :phone}
      it {should_not allow_value("123456").for :phone}
      it {should allow_value("0123456").for :phone}
    end

    context "validates length of email" do
      it {should_not allow_value("a").for :email}
      it {should_not allow_value("a"*126).for :email}
      it {should allow_value("duyettran0608@gmail.com").for :email}
    end

    context "validates length of password" do
      it {should_not allow_value("aaaaa").for :password}
      it {should_not allow_value("a"*4).for :password}
      it {should allow_value("abcd123").for :password}
    end

    context "validates length of address" do
      it {should_not allow_value("").for :address}
      it {should_not allow_value("a"*257).for :address}
      it {should allow_value("abcdef").for :address}
    end
  end

  context "columns" do
    it { is_expected.to have_db_column(:name).of_type :string }
    it { is_expected.to have_db_column(:email).of_type :string }
  end
end
