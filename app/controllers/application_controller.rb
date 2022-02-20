require 'sinatra/base'
require 'sinatra/reloader'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  register Sinatra::Reloader
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    redirect_to_home_page
  end

  helpers do

    def redirect_to_home_page
      redirect to "/expenses"
    end

    def redirect_to_categories
      redirect to "/categories"
    end

  end

end
