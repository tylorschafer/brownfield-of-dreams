# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, allow_nil: true
  validates_presence_of :first_name

  enum role: %i[default admin]
  has_secure_password

  def self.in_system?(handle)
    find_by(handle: handle)
  end

  def friend?(handle)
    friends.find_by(handle: handle)
  end

  def bookmarks_by_tutorial
    tutorials
      .order('videos.position')
  end

  def generate_token
    update(token: SecureRandom.hex(10))
    reload
  end
end
