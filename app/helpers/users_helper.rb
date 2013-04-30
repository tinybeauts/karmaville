module UsersHelper

  def current_page
    params[:page].to_i
  end
end
