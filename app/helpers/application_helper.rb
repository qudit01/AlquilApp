module ApplicationHelper
  def show_rental_link
    if current_user.stall?
      "<li>#{link_to 'AlquilApp', cars_path}</li>".html_safe
    else
      "<li>#{link_to 'AlquilApp', rental_path(current_user.rentals.last, car_id: current_user.rentals.last)}</li>".html_safe
    end
  end
end
