class ApplicationController < ActionController::Base
  include SessionsHelper

  def after_sign_in_path_for(resource)
    root_path # ルートパスにリダイレクト
  end
end
