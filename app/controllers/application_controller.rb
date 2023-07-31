class ApplicationController < ActionController::Base

  # This method determines the path to redirect after successful sign-in
  def after_sign_in_path_for(resource)
    # Replace 'messages_path' with the path to your messages part
    messages_path
  end
end
