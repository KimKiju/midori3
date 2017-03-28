class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #usernameを必須・一意とする
  validates_uniqueness_of :nickname
  validates_presence_of :nickname
  validates_presence_of :year
  validates_presence_of :group_id
  validates_presence_of :image

  has_many :stats

  mount_uploader :image, ImageUploader
end
