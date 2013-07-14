require 'spec_helper'

describe User do

  before do
    @user = FactoryGirl.create(:user)
    #~ @user = User.new(name: 'Savva', email: 'vcabba@rambler.ru', password: 'qqqwww', password_confirmation: 'qqqwww')
    @user.save
  end
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  
  it { should be_valid }
  
  describe 'pass didnt match confirmation' do
    before { @user.password_confirmation = "typo" }
    it { should_not be_valid }
  end
  
  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end
  
  it "can be saved successfully" do
    User.create(email: 'vcabba@bmail.ru', password: 'qqqwww', password_confirmation: 'qqqwww').should be_persisted
  end
  
  it 'has valid fact' do
    FactoryGirl.build(:user, email: "savva.voloshin@gmail.com").should be_valid
  end
  
  it 'can self authorise' do
    
    auth_hash = Hash.new
    
    auth_hash[:provider] = 'vk'
    auth_hash[:uid] = '31'
    auth_hash[:token] = 'aq1'
    auth_hash[:secret] = 'sw2'
    auth_hash['name'] = 'name'
    auth_hash['email'] = 'vcabba@bmail.ru'
    
    @user.add_authorisation(auth_hash)
    
    @user.authorisations.length.should == 1
    
  end
  
  it 'can update name, email, tokens' do
    
    auth_hash = Hash.new
    
    auth_hash[:provider] = 'vk'
    auth_hash[:uid] = '31'
    auth_hash[:token] = 'aq1'
    auth_hash[:secret] = 'sw2'
    auth_hash['name'] = 'name'
    auth_hash['email'] = 'vcabba@rambler.ru'
    
    @user.add_authorisation(auth_hash)
    
    auth_hash[:token] = 'aq1c'
    auth_hash[:secret] = 'sw2c'
    auth_hash['name'] = 'namec'
    auth_hash['email'] = 'vcabba@bmail.ru'
    
    @user.update_info(auth_hash)
    
    @user.name.should == 'namec'
    @user.email.should == 'vcabba@bmail.ru'
    
    auth = @user.authorisations.first
    auth.token.should == 'aq1c'
    auth.secret.should == 'sw2c'
    
  end
  
  describe "when email is incorrect" do # address is already taken" do
  
    before do
      @user.email = 'asd'
    end
    
    it { should_not be_valid }
  end

end
