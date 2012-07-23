require 'sinatra/base'
require 'sinatra/reloader'

class AjaxTestbedSimple < Sinatra::Base

#  s = ENV['SESSION_SECRET']
#  raise if s.nil? || ''==s
#  set :session_secret, s

  configure do
    enable :dump_errors
    enable :lock
    enable :logging
    enable :raise_errors
    enable :sessions

    disable :threaded
  end

  configure :development do
    Sinatra::Application.reset!
    register Sinatra::Reloader
  end

  before do
    @help = 'Send XmlHttpRequest (Ajax) requests (GET or POST) to /ajax'
    @ajax = ''
  end

  post('/ajax.?:format?') { @ajax }
  get( '/ajax.?:format?') { @ajax }

  post('/.?:format?') { @help }
  get( '/.?:format?') { @help }

#-------------
  protected

end

