class License < ApplicationRecord
    mount_uploader :photo, ImageUploader
    enum state: { pending: 0, toexpire: 1, expired: 2, ok: 3, rejected: 4 }
    belongs_to :user

    validates :state, presence: true, inclusion: {in: states.keys}
end