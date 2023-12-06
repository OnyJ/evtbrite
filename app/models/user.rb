class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :init_profile
  after_create :welcome_send

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :attendances
  has_many :events, through: :attendances

  def init_profile
    self.create_profile!
  end

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
