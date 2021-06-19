require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }
  describe 'login' do
    context 'correct' do
      it 'login' do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(current_path).to eq root_path
        expect(page).to have_content "ログインしました"
      end
    end

    context 'faild' do
      it 'can not login' do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "ppppppp"
        click_button "ログイン"
        expect(current_path).to eq login_path
        expect(page).to have_content "ログインに失敗しました"
      end
    end
  end

  describe 'logout' do
    xit 'redirects to login path' do
      login(user)
      click_on "ログアウト"
      expect(current_path).to eq login_path
      expect(page).to have_content "ログアウトしました"
    end
  end
end
