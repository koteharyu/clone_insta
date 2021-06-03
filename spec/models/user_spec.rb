# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  avatar                  :string
#  crypted_password        :string
#  email                   :string           not null
#  name                    :string           not null
#  notification_on_comment :boolean          default(TRUE)
#  notification_on_follow  :boolean          default(TRUE)
#  notification_on_like    :boolean          default(TRUE)
#  salt                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is valid with name, email, pass, pass_con' do
      expect(build(:user)).to be_valid
    end

    it 'is invalid without name' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include "を入力してください"
    end

    it 'is invalid without email' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include "を入力してください"
    end

    it 'is invalid without password' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include "は3文字以上で入力してください"
    end

    it 'is invalid without password_confirmation' do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include "を入力してください"
    end

    it 'is invalid with same email' do
      user = create(:user, email: "spec@example.com")
      other_user = build(:user, email: "spec@example.com")
      other_user.valid?
      expect(other_user.errors[:email]).to include "はすでに存在します"
    end
  end

  describe 'instance method ' do
    let!(:user) {create(:user)}
    let!(:other_user) {create(:user)}
    let!(:user_post) {create(:post, user: user)}
    let!(:other_post) {create(:post, user: other_user)}

    describe 'own?' do
      it 'returns true when user.own? user_post' do
        expect(user.own?(user_post)).to be true
      end

      it 'returens false when user.own? other_post' do
        expect(user.own?(other_post)).to be false
      end
    end

    describe 'like' do
      it 'likes other post' do
        expect{user.like(other_post)}.to change{other_post.likes.count}.by(1)
      end

      it 'unlike other post' do
        user.like(other_post)
        expect{user.unlike(other_post)}.to change{other_post.likes.count}.by(-1)
      end

      it 'is true that user like other post' do
        user.like(other_post)
        expect(user.like?(other_post)).to be true
      end

      it 'is false that user like other post' do
        expect(user.like?(other_post)).to be false
      end
    end

    describe 'follow' do
      it 'is increasing other_user.followers for user follow other user' do
        expect{user.follow other_user}.to change{other_user.followers.count}.by(1)
      end

      it 'is increasing user.following for user follow other user' do
        expect{user.follow other_user}.to change{user.following.count}.by(1)
      end

      it 'user unfollow other user' do
        user.follow(other_user)
        expect{user.unfollow(other_user)}.to change{ other_user.followers.count}.by(-1)
      end

      it 'user unfollow other user' do
        user.follow(other_user)
        expect{user.unfollow(other_user)}.to change{ user.following.count}.by(-1)
      end

      it 'is true that user is following other user' do
        user.follow other_user
        expect(user.follow?(other_user)).to be true
      end

      it 'is false that user is following other user' do
        expect(user.follow?(other_user)).to be false
      end
    end

    describe 'feed' do
      before do
        user.follow(other_user)
      end

      it 'user feed have user post' do
        expect(user.feed).to include user_post
      end

      it 'user feed have other user post' do
        expect(user.feed).to include other_post
      end

      it 'user feed not have other2 post' do
        user2 = create(:user)
        other2_post = create(:post, user: user2)
        expect(user.feed).to_not include other2_post
      end
    end

  end

end
