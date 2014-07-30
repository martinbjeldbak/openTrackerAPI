class UserSerializer < ActiveModel::Serializer
  def steam_id
    object.uid
  end

  attributes :id, :name, :steam_id, :admin, :sign_in_count, :current_sign_in_at,
             :last_sign_in_at, :current_sign_in_ip, :created_at, :updated_at
  has_many :sessions, embed: :ids

  def sessions
    object.sessions.where(user: object)
  end

  def filter(keys)
    if scope && scope.admin?
      keys
    else
      keys - [:admin, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
              :current_sign_in_ip, :created_at, :updated_at]
    end
  end
end
