class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "150x150#" }, default_url: "/app/images/missing.png"

  validates :username, presence: true, length: { minimum: 4, maximum: 18 }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
