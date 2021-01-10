class Tweet < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader
    attr_accessor :file
    acts_as_taggable
end
