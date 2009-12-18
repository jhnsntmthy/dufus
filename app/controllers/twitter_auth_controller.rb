require 'json'

class TwitterAuthController < ApplicationController
  def complete
    t = JSON.parse(get_access_token.get('/account/verify_credentials.json').body).symbolize_keys
    # here we want to do two things
    logger.debug get_access_token.inspect
    if current_user
      # then we want to create a twitter User with a link back to the logged_in account
      @twit = Twit.create({:name => t["name"], :screen_name => t["screen_name"], :oauth_token => get_access_token.token, :oauth_token_secret => get_access_token.secret })
    else
      # then we want to create a twitter standalone user and display a thank-you message
    end
  end
end
