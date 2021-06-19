class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :post_body, :string
  attribute :comment_body, :string
  attribute :user_name, :string

  def search
    scope = Post.distinct
    scope = split_post_body.map { |word| scope.post_like(word) }.inject { |result, scp| result.or(scp) } if post_body.present?
    scope = scope.comment_like(comment_body) if comment_body.present?
    scope = scope.user_like(user_name) if user_name.present?
    scope
  end

  private

  def split_post_body
    post_body.strip.split(/[[:blank:]]+/)
  end
end
