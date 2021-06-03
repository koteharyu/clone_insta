class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :post_body, :string
  attribute :comment_body, :string
  attribute :user_name, :string

  def search
    scope = Post.all
    scope = scope.body_contain(body) if body.present?
    scope
  end
end
