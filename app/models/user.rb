class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone_number, uniqueness: true
  validates :email, uniqueness:  true
  belongs_to :parent, class_name: 'User', counter_cache: :children_members, optional: true
  has_many :children, class_name: 'User', foreign_key: :parent_id
  has_many :user_address
  enum genre: { client: 0, admin: 1 }
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
end
