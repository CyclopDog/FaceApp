class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, foreign_key: "creator_id"
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "recipient_id"
  belongs_to :location, required: false
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


   def confirmed_friends
     created_friendships = Array.new
     created_friendships = friendships.select { |i| i.status == true }.map do |f|
       f.recipient
     end

     received_friendships = Array.new
     received_friendships = inverse_friendships.select { |i| i.status == true }.map do |f|
      f.recipient
     end

     (created_friendships + received_friendships)
    end

    def pending_friendships
      pending = Array.new
      pending = friendships.select { |i| i.status == false }
    end

    def pending_invites
      pending = Array.new
      pending = inverse_friendships.select { |i| i.status == false }.map do |f|
        f.creator
      end
    end

end
