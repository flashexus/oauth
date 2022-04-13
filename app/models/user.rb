class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: ["keyrock"]

  def self.find_or_create_with_keyrock(auth)
    user = self.find_by(provider: auth.provider, uid: auth.uid )
    p "-------find user---------"
    p auth
    return user unless user.nil?
    p "-------create user---------"
  
    self.create!(
      email: auth.info.email,
      provider: auth.info.provider,
      uid: auth.uid,
      name: auth.info.name,
      password: Devise.friendly_token[0, 20]
    )
  end

end
