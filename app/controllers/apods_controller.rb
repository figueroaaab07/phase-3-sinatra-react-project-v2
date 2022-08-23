class ApodsController < ApplicationController
  # Add your routes here
  # Apod Routes

  # Read - Get Request Apods
  get '/apods' do
    apods = Apod.all 
    apods.to_json
  end

  # Read - Get Request Apod by ID
  get '/apods/:id' do
    apod = Apod.find(params[:id])
    apod.to_json
  end
end