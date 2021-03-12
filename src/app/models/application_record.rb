class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def display_feed_image
    begin
      image.variant(resize_to_limit: [60, 60])      
    rescue => exception      
      return image
    end
  end
end
