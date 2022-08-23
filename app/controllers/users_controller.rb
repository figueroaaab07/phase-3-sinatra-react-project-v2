class UsersController < ApplicationController
  # Add your routes here
  # User Routes

  # Read - Get Request Users
  get '/users' do
    users = User.all
    users.to_json
  end

  # Read - Get Request User by ID
  get '/users/:id' do
    user = User.find(params[:id])
    user.to_json(include: [:apods])
    # user.to_json
  end

  # Read - Get Request Apods by User ID
  get '/users/:id/apods' do
    user = User.find(params[:id])
    user_apods = user.apods
    user_apods.to_json
    # user.apods.to_json
  end

  # Create - Post Request User
  post "/users" do
    new_user = User.create({
      first_name: params[:first_name],
      last_name: params[:last_name],
      birth_date: params[:birth_date]
    })
    # new_apod_ids = Apod.select(:id).where("STRFTIME('%m-%d', date) = ?", (params[:birth_date])[5..9])
    new_apod_ids = Apod.select(:id).where("SUBSTRING(date FROM 6 FOR 10) = ?", (params[:birth_date])[5..9])
    new_user.apods << Apod.find(new_apod_ids.map{ |h| h[:id].to_i })
    new_user.to_json(include: [:apods])
  end

  # Delete - Delete Request User by ID
  delete "/users/:id" do
    user = User.find(params[:id])
    # user.user_apods.destroy_all
    UserApod.where(user_id: params[:id]).delete_all
    user.destroy
    user.to_json
  end
end
