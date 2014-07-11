require 'spec_helper'

describe PlayerImport, :type => :model do
  before do
    @player = PlayerImport.new()
  end

  subject { @player }

  it { should respond_to(:player_id) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:country) }
  it { should respond_to(:gender) }
  it { should respond_to(:alt_last_name_1) }
  it { should respond_to(:alt_last_name_2) }
  it { should respond_to(:hand) }
  it { should respond_to(:backhand) }
  it { should respond_to(:msgs) }

  it { should be_valid }

end
