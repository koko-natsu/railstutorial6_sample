class User < ApplicationRecord

  before_save { email.downcase! }

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  # returns a hash of the passed string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # NOTE:
  # self.min_cost = false
  # 
  # def min_cost
  #   @min_cost
  # end
  # 
  # true in test environment
  # ActiveModel::Railtie
  # initializer "active_model.secure_password" do
  #   ActiveModel::SecurePassword.min_cost = Rails.env.test?
  # end
  # 
  # BCrypt::Engine::MIN_COST = 4
  # 
  # https://naokirin.hatenablog.com/entry/2019/03/29/032801#has_secure_password-%E3%81%A8%E3%81%AF

end