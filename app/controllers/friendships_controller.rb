class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy, :update]

  def index
    @friends = current_user.confirmed_friends
  end

  def create
      @friendship = Friendship.new(friend_params)
      @friendship.creator_id = current_user.id
      @friendship.status = false
      if @friendship.save
        redirect_to users_path
      else
        redirect_to :root, notice: 'Request failed'
      end
  end

  def destroy
    @friendship.destroy
      flash[:success] = "Request Cancelled"
      redirect_to users_path
  end

  def update
    @friendship.status = true
    if @friendship.save
      redirect_to users_path
    else
      redirect_to users_path, notice: 'Request failed'
    end
  end

  private
    def friend_params
      params.require(:friendship).permit(:recipient_id)
    end

    def set_friendship
      @friendship = Friendship.find(params[:id])
    end
end
