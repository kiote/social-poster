
module OauthMocking
	def login_with_oauth(provider = :facebook)
		visit "/auth/#{provider}"
	end
end
