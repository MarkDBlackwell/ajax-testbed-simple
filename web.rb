require 'sinatra/base'
require 'sinatra/reloader'

=begin
Ref:
https://developer.mozilla.org/En/Server-Side_Access_Control
=end 

class AjaxTestbedSimple < Sinatra::Base

  
  RESPONSE_STATUS_OK = 200
  RESPONSE_HEADERS = {
      'Access-Control-Allow-Origin' => '*',

       }
  RESPONSE_AJAX = [ '{ "message": "hello" }', "\n" ]
  RESPONSE_HELP = [ 'Send XmlHttpRequest (Ajax) requests (GET or POST) to /ajax', "\n" ] # Should respond to #each.

#  s = ENV['SESSION_SECRET']
#  raise if s.nil? || ''==s
#  set :session_secret, s

  configure do
    enable :dump_errors, :lock, :logging, :method_override, :show_exceptions
    disable :protection, :raise_errors, :sessions, :static, :threaded
  end

  configure :development do
    Sinatra::Application.reset!
    register Sinatra::Reloader
  end

  before do
    cache_control :private, :must_revalidate, :max_age => 0
  end

  post('/ajax.?:format?') { [ RESPONSE_STATUS_OK, RESPONSE_HEADERS, RESPONSE_AJAX ] }
  get( '/ajax.?:format?') { [ RESPONSE_STATUS_OK, RESPONSE_HEADERS, RESPONSE_AJAX ] }

  post('/.?:format?'    ) { [ RESPONSE_STATUS_OK, RESPONSE_HEADERS, RESPONSE_HELP ] }
  get( '/.?:format?'    ) { [ RESPONSE_STATUS_OK, RESPONSE_HEADERS, RESPONSE_HELP ] }

#-------------
  protected

end

