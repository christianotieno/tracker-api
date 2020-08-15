module V2
  class StaticPageController < ApplicationController
    def home
      render json: 'Welcome to the Schedule Tracker\'s API'
    end
  end
end
