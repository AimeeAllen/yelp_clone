class PagesController < ApplicationController
  skip_before_filter :redirect_if_not_logged_in
end
