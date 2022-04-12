class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[doorkeeper]

  def self.find_or_create_with_doorkeeper(auth)
    user = self.find_by(provider: auth.provider, uid: auth.uid )
    return user unless user.nil?
  
    self.create(
      email: auth.info.user.email,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0, 20]
    )
  end

end
