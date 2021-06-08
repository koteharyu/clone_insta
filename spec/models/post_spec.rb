# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  images     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    it 'is valid with body and images' do
      expect(build(:post)).to be_valid
    end

    it 'is valid with multiple-images' do
      expect(build(:post, :multiple_images)).to be_valid
    end

    it 'is invalid without body' do
      post = build(:post, body: nil)
      post.valid?
      expect(post.errors[:body]).to include "を入力してください"
    end

    it 'is invalid without images' do
      post = build(:post, images: nil)
      post.valid?
      expect(post.errors[:images]).to include "を入力してください"
    end

    it 'is invalid with more 1001 chars' do
      post = build(:post, body: "a" * 1001)
      post.valid?
      expect(post.errors[:body]).to include "は1000文字以内で入力してください"
    end
  end

  describe 'search' do
    let(:user) { create(:user, name: "user1")}
    let(:post) { create(:post, body: "fugafuga", user: user)}
    let(:comment) { create(:comment, body: "hogehoge", post: post, user: user)}

    describe 'post_like' do
      context '検索ワードに一致する投稿が存在する場合' do
        it 'returns the posts' do
          expect(Post.post_like("fuga")).to include post
        end
      end

      context '検索ワードに一致する投稿が存在しない場合' do
        it 'doesnt returns any posts' do
          expect(Post.post_like("huga")).to be_empty
        end
      end
    end

    describe 'user_like' do
      context '検索ワードに一致する投稿が存在する場合' do
        it 'returns the posts' do
          expect(Post.user_like("user1")).to eq (user.posts)
        end
      end

      context '検索ワードに一致する投稿が存在しない場合' do
        it 'doesnt returns any posts' do
          expect(Post.user_like("fuga")).to be_empty
        end
      end
    end

    describe 'comment_like' do
      context '検索ワードに一致する投稿が存在しない場合' do
        xit 'returns the posts' do
          expect(Post.comment_like("ho")).to include(comment.post)
        end
      end

      context '検索ワードに一致する投稿が存在しない場合' do
        it 'doesnt returns any posts' do
          expect(Post.comment_like("fu")).to be_empty
        end
      end
    end

  end
end
