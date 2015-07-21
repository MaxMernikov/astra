class PotentialFriends
  # 308166833 <- my id
  # 84735
  # PotentialFriends.get_some(84735)

  def self.get_some(user_id, count = 30)
    @vk = VkontakteApi::Client.new(Admin.first.vk_token)
    my_friends = @vk.friends.get(uid: 308166833)

    potential = []

    # @vk.friends.get(uid: user_id, count: count, fields: [:sex, :city]) do |friend|
    @vk.friends.get(uid: user_id, count: 100, fields: [:sex, :city]) do |friend|
      potential << friend if my_friends.exclude?(friend.uid) && friend.sex == 1 && friend.deactivated == nil && friend.city == 282

    end

    potential_ids = potential.map{|i| i.uid}
    are_friend = @vk.friends.areFriends(user_ids: potential_ids)

    are_not_friend = are_friend.map{|i| i.uid if i.friend_status == 0}
    potential = potential.map{ |i| i if are_not_friend.include?(i.uid) }.compact

    potential
  end
end