require 'rails_helper'

RSpec.describe Country, :type => :model do
  before do
    @country = Country.new(code_2: "UT", code_3: "UTO", code_num: 666, name: "Utopia")
  end

  subject { @country }

  it { should respond_to(:code_2) }
  it { should respond_to(:code_3) }
  it { should respond_to(:code_num) }
  it { should respond_to(:name) }
  it { should respond_to(:code_4) }

  it { should be_valid }

  describe "attribute code 2" do
    describe "must exist" do
      before { @country.code_2 = nil }
      it { should_not be_valid }
    end

    describe "must meet min length constraint" do
      before { @country.code_2 = "xx" }
      it { should be_valid }
    end

    describe "must fail min length constraint" do
      before { @country.code_2 = "x" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @country.code_2 = "x" * 2 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @country.code_2 = "x" * 3 }
      it { should_not be_valid }
    end

    describe "must not be a duplicate" do
      before do
        @country.save!
      end

      it "should not save new country with same value" do
        @country2 = Country.new(code_2: "UT", code_3: "UT1", code_num: 667, 
                              name: "UtopiaXXX")
        expect{ @country2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "attribute code 3" do
    describe "must exist" do
      before { @country.code_3 = nil }
      it { should_not be_valid }
    end

    describe "must meet min length constraint" do
      before { @country.code_3 = "xxx" }
      it { should be_valid }
    end

    describe "must fail min length constraint" do
      before { @country.code_3 = "xx" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @country.code_3 = "x" * 3 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @country.code_3 = "x" * 4 }
      it { should_not be_valid }
    end

    describe "must not be a duplicate" do
      before do
        @country.save!
      end

      it "should not save new country with same value" do
        @country2 = Country.new(code_2: "UX", code_3: "UTO", code_num: 667, 
                              name: "UtopiaXXX")
        expect{ @country2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "attribute code num" do
    describe "must exist" do
      before { @country.code_num = nil }
      it { should_not be_valid }
    end

    describe "must not be a duplicate" do
      before do
        @country.save!
      end

      it "should not save new country with same value" do
        @country2 = Country.new(code_2: "U1", code_3: "UT1", code_num: 666, 
                              name: "UtopiaXXX")
        expect{ @country2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "attribute name" do
    describe "must exist" do
      before { @country.name = nil }
      it { should_not be_valid }
    end

    describe "must not be a duplicate" do
      before do
        @country.save!
      end

      it "should not save new country with same value" do
        @country2 = Country.new(code_2: "U1", code_3: "UT1", code_num: 667, 
                              name: "Utopia")
        expect{ @country2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "attribute code 4" do
    describe "null value is allowed" do
      before { @country.code_4 = nil }
      it { should be_valid }
    end

    describe "must meet min length constraint" do
      before { @country.code_4 = "xxxx" }
      it { should be_valid }
    end

    describe "must fail min length constraint" do
      before { @country.code_4 = "xxx" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @country.code_4 = "x" * 4 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @country.code_4 = "x" * 5 }
      it { should_not be_valid }
    end

    describe "must not be a duplicate" do
      before do
        @country.code_4 = "OLD1"
        @country.save!
      end

      it "should not save new country with same value" do
        @country2 = Country.new(code_2: "U1", code_3: "UT1", code_num: 667, 
                              name: "UtopiaXXX", code_4: "OLD1")
        expect{ @country2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
