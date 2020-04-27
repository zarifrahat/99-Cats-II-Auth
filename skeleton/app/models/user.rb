class User < ApplicationRecord

    validates :user, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true  

    #after_initialize

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.reset_session_token!
        self.session_token = User.generate_session_token
        self.save! 
        self.session_token #why are we returning this?
    end

    def password=(password)
        @password = password

        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        entered_password = BCrypt::Password.create(password)
        entered_password == password_digest
    end

    def self.find_by_credentials(user_name, password)
        user = User.find_by(username: user_name)

        if user && user.is_password?(password_digest)
            return user
        else
            return nil
        end
    end
    

end