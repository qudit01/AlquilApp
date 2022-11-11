class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  NAMES_FORMAT = /\A[\p{L}\s]+\z/i
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
