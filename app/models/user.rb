class User < ApplicationRecord

  #パスワードを6文字以上の設定
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_one_attached :avatar
end
