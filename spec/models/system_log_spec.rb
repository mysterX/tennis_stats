require 'rails_helper'

RSpec.describe SystemLog, :type => :model do
  before do
    @log = SystemLog.new(comment: "Test_Comment_13579")
  end

  subject { @log }

  it { should respond_to(:comment) }

  it { should be_valid }

  describe "attribute comment" do
    describe "must exist" do
      before { @log.comment = nil }
      it { should_not be_valid }
    end

    describe "empty string is not allowed" do
      before { @log.comment = "" }
      it { should_not be_valid }
    end
  end
end
