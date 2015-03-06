class InstaCache < ActiveRecord::Base
  serialize :info_hash

  belongs_to :insta_user

  def self.get(cache_type, insta_user_id, params = nil)
    response = InstaCache.where(cache_type: cache_type, insta_user_id: insta_user_id).where('created_at > ?', Time.now - 1.day).first.try(:info_hash)

    unless response
      result = false

      begin
        response = $insta_client.send(cache_type, insta_user_id, params) 
        InstaCache.create(cache_type: cache_type, insta_user_id: insta_user_id, info_hash: response)
      rescue Instagram::BadRequest
        ap 'Instagram::BadRequest'
      end
    end

    response
  end
end
