require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  it 'creates a valid instance' do
    expect { expect(@user.email).to eq('first.last@example.com') }
    expect { expect(@user.password).to eq('123456') }
  end
end
