class RepositoriesController < ApplicationController

	def index
		resp = Faraday.get('https://api.github.com/user') do |req|
			req.params['access_token'] = session[:token]
		end
		@username = JSON.parse(resp.body)['login']
		resp = Faraday.get('https://api.github.com/user/repos') do |req|
			req.params['access_token'] = session[:token]
		end
		@repos = JSON.parse(resp.body)
  end

end
