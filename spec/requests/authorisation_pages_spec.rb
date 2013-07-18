require 'spec_helper'

describe 'Authorisation pages' do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user}
  
  describe 'authorisation destruction' do
    before { FactoryGirl.create(:authorisation, user: user) }
    
    describe 'as correct user' do
      before { visit root_path }
      
      it 'should delete an authorisation' do
        expect { click_link 'delete' }.to change(Authorisation, :count).by(-1)
      end
    end
    
  end
  
  describe 'authorisation creation' do

    describe 'as correct user' do
      before { visit root_path }
      
      it 'should create an authorisation' do
        expect { FactoryGirl.create(:authorisation, user: user) }.to change(Authorisation, :count).by(1)
      end
    end
    
  end
  
end
