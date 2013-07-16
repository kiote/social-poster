
require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('Social Poster') }
    it { should have_title(full_title('')) }
    it { should_not have_title('Why not?') }
  end
  
  describe "Help page" do
    before { visit help_path }
    
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
  
  it 'should have correct links on the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_title(full_title('About'))
    
    click_link 'Help'
    expect(page).to have_title(full_title('Help'))
    
    click_link 'Contact'
    expect(page).to have_title(full_title('Contact'))
    
    click_link 'Home'
    click_link 'sign up'
    expect(page).to have_title(full_title('Sign up'))
    
    click_link 'Social Poster'
    expect(page).to have_title(full_title('Social Poster'))

  end
  
end

