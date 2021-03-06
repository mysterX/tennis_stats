require 'rails_helper'

describe Player, :type => :model do
  before do
    Country.new(code_2: "UT", code_3: "UTO", code_num: 666, name: "Utopia").save
    @country = Country.find_by(code_3: "UTO")
    @player = Player.new(p_code: "UMach", first_name: "Ultra", last_name: "Machismo",
                         country: @country, gender: "M")
  end

  subject { @player }

  it { should respond_to(:p_code) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:country) }
  it { should respond_to(:gender) }
  it { should respond_to(:alt_last_name_1) }
  it { should respond_to(:alt_last_name_2) }
  it { should respond_to(:hand) }
  it { should respond_to(:backhand) }

  it { should be_valid }

  describe "attribute p_code" do
    describe "must exist" do
      before { @player.p_code = nil }
      it { should_not be_valid }
    end

    describe "must meet min length constraint" do
      before { @player.p_code = "x" }
      it { should be_valid }
    end

    describe "must fail min length constraint" do
      before { @player.p_code = "" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.p_code = "x" * 10 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.p_code = "x" * 11 }
      it { should_not be_valid }
    end

    describe "must not be a duplicate" do
      before do
        @player.save!
      end

      it "should not save new player with same id" do
        @player2 = Player.new(p_code: "UMach", first_name: "Ultra2", 
                              last_name: "Machismo2",
                              country: @country, gender: "M")
        expect{ @player2.save! }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

    describe "saved as lower case" do
      let(:mixed_case_p_code) { "umach" }
      
      it "should be saved as all lower-case" do
        @player.save!
        expect(@player.reload.p_code).to eq mixed_case_p_code
      end
    end
  end

  describe "attribute first_name" do
    describe "must exist" do
      before { @player.first_name = nil }
      it { should_not be_valid }
    end

    describe "must meet min length constraint" do
      before { @player.first_name = "x" }
      it { should be_valid }
    end

    describe "must fail min length constraint" do
      before { @player.first_name = "" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.first_name = "x" * 45 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.first_name = "x" * 46 }
      it { should_not be_valid }
    end
  end

  describe "attribute last_name" do
    describe "must exist" do
      before { @player.last_name = nil }
      it { should_not be_valid }
    end

    describe "must meet min length constraint" do
      before { @player.last_name = "x" }
      it { should be_valid }
    end

    describe "must fail min length constraint" do
      before { @player.last_name = "" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.last_name = "x" * 45 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.last_name = "x" * 46 }
      it { should_not be_valid }
    end
  end

  describe "attribute country" do
    describe "must exist" do
      before { @player.country = @country }
      it { should be_valid }
    end

    describe "must not be nil" do
      before { @player.country = nil }
      it { should_not be_valid }
    end

    it "must match country name" do
      expect(@player.country.name).to eq('Utopia')
    end

    it "must match country code3" do
      expect(@player.country.code_3).to eq('UTO')
    end

    it "must match country code2" do
      expect(@player.country.code_2).to eq('UT')
    end
  end

  describe "attribute gender" do
    describe "must exist" do
      before { @player.gender = nil }
      it { should_not be_valid }
    end

    describe "must meet min length constraint" do
      before { @player.gender = "M" }
      it { should be_valid }
    end

    describe "empty string is not allowed" do
      before { @player.gender = "" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.gender = "F" * 1 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.gender = "F" * 2 }
      it { should_not be_valid }
    end

    describe "must be included value" do
      describe "F for female" do
        before { @player.gender = "F" }
        it { should be_valid }
      end

      describe "M for male" do
        before { @player.gender = "M" }
        it { should be_valid }
      end

      describe "X for garbage" do
        before { @player.gender = "X" }
        it { should_not be_valid }
      end
    end
  end

  describe "attribute alt_last_name_1" do
    describe "must meet min length constraint" do
      before { @player.alt_last_name_1 = "x" }
      it { should be_valid }
    end

    describe "empty string is allowed" do
      before { @player.alt_last_name_1 = "" }
      it { should be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.alt_last_name_1 = "x" * 45 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.alt_last_name_1 = "x" * 46 }
      it { should_not be_valid }
    end
  end

  describe "attribute alt_last_name_2" do
    describe "must meet min length constraint" do
      before { @player.alt_last_name_2 = "x" }
      it { should be_valid }
    end

    describe "empty string is allowed" do
      before { @player.alt_last_name_2 = "" }
      it { should be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.alt_last_name_2 = "x" * 45 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.alt_last_name_2 = "x" * 46 }
      it { should_not be_valid }
    end
  end

  describe "attribute hand" do
    describe "must meet min length constraint" do
      before { @player.hand = "L" }
      it { should be_valid }
    end

    describe "empty string is not allowed" do
      before { @player.hand = "" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.hand = "R" * 1 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.hand = "R" * 2 }
      it { should_not be_valid }
    end

    describe "must be included value" do
      describe "L for left-handed" do
        before { @player.hand = "L" }
        it { should be_valid }
      end

      describe "R for right-handed" do
        before { @player.hand = "R" }
        it { should be_valid }
      end

      describe "X for garbage" do
        before { @player.hand = "X" }
        it { should_not be_valid }
      end
    end
  end

  describe "attribute backhand" do
    describe "must meet min length constraint" do
      before { @player.backhand = "1" }
      it { should be_valid }
    end

    describe "empty string is not allowed" do
      before { @player.backhand = "" }
      it { should_not be_valid }
    end

    describe "must meet max length constraint" do
      before { @player.backhand = "2" * 1 }
      it { should be_valid }
    end

    describe "must fail max length constraint" do
      before { @player.backhand = "B" * 2 }
      it { should_not be_valid }
    end

    describe "must be included value" do
      describe "1 for one-handed backhand" do
        before { @player.backhand = "1" }
        it { should be_valid }
      end

      describe "2 for double-handed backhand" do
        before { @player.backhand = "2" }
        it { should be_valid }
      end

      describe "B for double-handed forehand and backhand" do
        before { @player.backhand = "B" }
        it { should be_valid }
      end

      describe "X for garbage" do
        before { @player.backhand = "X" }
        it { should_not be_valid }
      end
    end
  end
end
