class SessionsController < Devise::SessionsController
  skip_before_filter :verify_logged_in
end