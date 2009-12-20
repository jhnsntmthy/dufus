require 'json'

class TwitterAuthController < ApplicationController
  def complete
    logger.debug get_access_token.inspect
    logger.debug "user_id: #{(get_access_token.params["user_id"])}"
    logger.debug "token: #{get_access_token.token}"
    logger.debug "secret: #{get_access_token.secret}"
    
    @twit = current_twitter_user
    
    if !current_user 
      if @twit
        # Twitter user exists in the system
        if @twit.user
          # user account found, log in as such
          flash[:notice] = "That twitter account already has an account here, please sign in with this form."
          redirect_to "/"
        else
          # user account not found, send to "welcome again screen"
          @scenario = "twitter_only_account_logged_in_again"
        end
      else
        create_twit_account
        @scenario = "successfully_created_twitter_only_account"
      end
    else
      if @twit.nil?
        # then we want to create a twitter User with a link back to the logged_in account
        create_twit_account
        current_user.update_attribute "twit_id", @twit.id
        @scenario = "user_account_linked_to_twitter"
      else
        # prolly we got here by accident, because the user is already logged in and has an existing twitter account
        @scenario = "redirect to account, something is amiss"
        redirect_to account_url
      end
    end
    logger.debug @scenario
  end
  
  
  
  protected 
    def create_twit_account
      t = JSON.parse(get_access_token.get('/account/verify_credentials.json').body)
      logger.debug "T KEYS ------------"
      logger.debug t.keys.inspect
      @twit = Twit.create({:name => t["name"], :screen_name => t["screen_name"], :oauth_token => get_access_token.token, :oauth_token_secret => get_access_token.secret, :twitter_user_id => get_access_token.params["user_id"] })
    end
end
