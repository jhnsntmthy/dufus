$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) ||
    $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'expose_model/expose_model'
require 'expose_model/action_view'
