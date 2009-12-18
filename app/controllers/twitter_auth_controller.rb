require 'json'

class TwitterAuthController < ApplicationController
  def complete
    @twit = JSON.parse(get_access_token.get('/account/verify_credentials.json').body)
    # here we want to do two things
    if current_user
      # then we want to create a twitter User with a link back to the logged_in account
    else
      # then we want to create a twitter standalone user and display a thank-you message
    end
    render :text => @twit.inspect
  end
end
