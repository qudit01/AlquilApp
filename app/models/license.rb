class License < ApplicationRecord
    mount_uploader :photo, ImageUploader
    enum state: { nolicense: 0, toexpire: 1, expired: 2 }
    belongs_to :user
end