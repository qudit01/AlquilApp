module UserHelper
  def valid_license?
    current_user.licenses.last.pending? || current_user.licenses.last.expired? || current_user.licenses.last.rejected?
  end
end
