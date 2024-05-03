class User < ApplicationRecord
  #パスワードを6文字以上の設定
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

  # Active Storageを使用したアバター画像の添付
  has_one_attached :avatar
end
