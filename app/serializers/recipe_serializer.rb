class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :minutes_to_complete
  has_one :user

  def minutes_to_complete
    object.minutes_to_complete.to_i
  end
end
