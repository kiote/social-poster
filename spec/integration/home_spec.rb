
require 'spec_helper'

describe 'home page' do
	it 'attend to sign in' do
		visit '/'
		page.should have_content('twitter')
		page.should have_content('facebook')
		page.should have_content('vkontakte')
		page.should have_content('linkedin')
	end
end
