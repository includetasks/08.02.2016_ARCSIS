# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  first_name             :string           not null
#  last_name              :string           not null
#  phone                  :string
#  is_active              :boolean          default(TRUE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # See: prepare_params method.
  before_save :prepare_params

  # WillPaginate default option.
  # Maximum elements per collection.
  self.per_page = 10

  # Model validators.
  validates :email,      presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :phone,      presence: true
  
  # Devise included options.
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Prepares params before model saving.
  def prepare_params
    self.email = self.email.downcase
  end
end
