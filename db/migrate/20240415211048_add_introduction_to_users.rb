class AddIntroductionToUsers < ActiveRecord::Migration[6.1]

  #プロフィール/自己紹介
  def change 
    add_column :users, :introduction, :text
  end
end
