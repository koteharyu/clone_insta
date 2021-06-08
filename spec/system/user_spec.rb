require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'sign up' do
    context 'correct data' do
      it 'redirects to root_path' do
        visit new_user_path
        fill_in "ユーザー名", with: "haryu"
        fill_in "メールアドレス", with: "haryu@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード確認", with: "password"
        click_on "登録"
        expect(current_path).to eq root_path
        expect(page).to have_content "ユーザーを作成しました"
      end
    end

    context 'incorrenct data' do
      it 'redirects to new_user_path' do
        visit new_user_path
        fill_in "ユーザー名", with: "haryu"
        fill_in "メールアドレス", with: "haryu@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード確認", with: "passworddd"
        click_on "登録"
        expect(page).to have_content "ユーザーの作成に失敗しました"
      end
    end
  end

  describe 'Follow and Unfollow' do
    let!(:user1) {create(:user, name: "user1")}
    let!(:user2) {create(:user, name: "user2")}
    context 'follow' do
      it 'follow' do
        login(user1)
        visit posts_path
        expect{
          within "#follow-area-#{user2.id}" do
            click_on "フォロー"
          end
        }.to change{user1.following.count}.by(1)
      end

      context 'unfollow' do
        it 'unfollow' do
          login(user1)
          visit posts_path
          user1.follow(user2)
          visit posts_path
          expect{
            within "#follow-area-#{user2.id}" do
              click_on "アンフォロー"
            end
          }.to change{user1.following.count}.by(-1)
        end
      end
    end
  end
end
