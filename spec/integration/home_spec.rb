
require 'spec_helper'

describe 'home page' do
	it 'attend to sign in' do
		visit '/'
		page.should have_content('twitter')
	end
end
