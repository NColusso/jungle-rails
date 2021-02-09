class User < ActiveRecord::Base
  has_secure_password
  validates :name, :password_confirmation, presence:true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
     if user && user.authenticate(password)
      user
     else
      nil
     end
  end

end
