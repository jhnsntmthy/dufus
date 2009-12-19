require 'json'

class TwitterAuthController < ApplicationController
  def complete
    logger.debug get_access_token.inspect
    logger.debug "user_id: #{(get_access_token.params["user_id"])}"
    logger.debug "token: #{get_access_token.token}"
    logger.debug "secret: #{get_access_token.secret}"

    t = JSON.parse(get_access_token.get('/account/verify_credentials.json').body)
    
    @twit = Twit.find_by_twitter_user_id get_access_token.params["user_id"]
    if current_user && @twit.nil?
      # then we want to create a twitter User with a link back to the logged_in account
      @twit = Twit.create({:name => t["name"], :screen_name => t["screen_name"], :oauth_token => get_access_token.token, :oauth_token_secret => get_access_token.secret, :twitter_user_id => get_access_token.params["user_id"] })
      current_user.update_attribute "twit_id", @twit.id
    else
      # then we want to create a twitter standalone user and display a thank-you message
    end
  end
end
