require 'rails_helper'

RSpec.describe 'Chat', type: :system do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  it 'ユーザーの詳細ページに「メッセージ」ボタンが存在すること' do
    login(user)
    visit user_path(user2)
    expect(page).to have_selector(:link_or_button, "メッセージ")
  end

  it '「メッセージ」ボタンを押すと該当ユーザーとのチャットルームに遷移すること' do
    login(user)
    visit user_path(user2)
    click_on "メッセージ"
    expect(current_path).to eq chatroom_path(Chatroom.first)
  end

  it 'テキストを入力して投稿ボタンを押すとメッセージが投稿されること' do
    login(user)
    visit user_path(user2)
    click_on "メッセージ"
    fill_in "メッセージ", with: "hello world"
    click_on "投稿"
  end

  xit 'コメントの編集ボタンを押すとモーダルが表示されコメントの更新ができること' do
    login(user)
    visit user_path(user2)
    click_on 'メッセージ'
    fill_in "メッセージ", with: "hello world"
    find("#create-button").click
    find(".edit-button").click
    within "#modal-container" do
      fill_in "メッセージ", with: "update hello world"
      click_on "更新"
    end
    expect(page).to have_content "update hello world"
  end

  xit 'コメントの削除ボタンを押すと確認ダイアログが出て「OK」ボタンを押すとコメントが削除されて画面から消えること' do
    login(user)
    visit user_path(user2)
    click_on "メッセージ"
    expect(current_path).to eq chatroom_path(Chatroom.first)
    fill_in 'メッセージ', with: 'hello world'
    find("#create-button").click
    expect(page).to have_content "hello world"
    page.accept_confirm { find(".delete-button").click }
    expect(page).to_not have_content 'hello world'
  end
end
