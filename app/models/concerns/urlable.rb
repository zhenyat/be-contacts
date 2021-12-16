################################################################################
#   Handles and validates url attribute to be saved
################################################################################
module Urlable
  extend ActiveSupport::Concern
  require 'uri'
  
  included do
    before_save {self.url.downcase!}

    # VALID_URL_REGEX = /^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$/
    # validates :url, format: {with: VALID_URL_REGEX}, uniqueness: {case_sensitive: false}
  
  end
end