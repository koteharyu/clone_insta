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
        expect(current_path).to eq login_path
        expect(page).to have_content "ユーザーを作成しました"
      end
    end
  end
end
