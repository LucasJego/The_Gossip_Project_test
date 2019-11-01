module LikesHelper
  
  def like?(potin)
    if Like.find_by(user_id: current_user.id, potin_id: potin.id).nil?
      return false
    else 
      return true
      id = like.id
    end
  end
end
