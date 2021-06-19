require 'rails_helper'

RSpec.describe 'Post', type: :system do
  let!(:user1) {create(:user, name: "user1")}
  let!(:user2) {create(:user, name: "user2")}
  let!(:user3) {create(:user, name: "user3")}
  let!(:post1) {create(:post, user_id: user1.id)}
  let!(:post2) {create(:post, user_id: user2.id)}
  let!(:post3) {create(:post, user_id: user3.id)}
  describe 'posts/index' do
    context 'not login' do
      it 'can posts/index' do
        visit posts_path
        expect(page).to have_content post1.body
        expect(page).to have_content post2.body
        expect(page).to have_content post3.body
      end
    end

    context 'logged in' do
      before do
        login(user1)
        user1.follow(user2)
      end
      it 'contains only post1 and post2' do
        visit posts_path
        expect(page).to have_content post1.body
        expect(page).to have_content post2.body
        expect(page).to_not have_content post3.body
      end
    end
  end

  describe 'posts/create' do
    let!(:user) {create(:user)}
    before do
      login(user)
    end

    it 'creates a new post' do
      visit new_post_path
      attach_file "画像", Rails.root.join('spec', 'fixtures', 'fixture.png')
      fill_in "本文", with: "test body"
      click_on "登録する"
      expect(page).to have_content "投稿に成功しました"
      expect(page).to have_content "test body"
    end
  end

  describe 'edit/update' do
    before do
      login(user1)
    end

    it 'display a edit button with post1' do
      visit root_path
      within "#post-#{post1.id}" do
        expect(page).to have_css '.edit-button'
      end
    end

    it 'not display a edit button with post2' do
      user1.follow user2
      visit root_path
      within "#post-#{post2.id}" do
        expect(page).to_not have_css '.edit-button'
      end
    end

    it 'update a post1' do
      visit edit_post_path(post1)
      within "#posts_form" do
        attach_file '画像', "#{Rails.root}/spec/fixtures/fixture.png"
        fill_in '本文', with: 'update spec'
        click_on '更新する'
      end
      expect(page).to have_content '投稿の更新に成功しました'
      expect(current_path).to eq posts_path
    end
  end

  describe 'destroy' do
    before do
      login(user1)
    end

    it 'display a delete button with post1' do
      visit root_path
      within "#post-#{post1.id}" do
        expect(page).to have_css ".delete-button"
      end
    end

    it 'not display a delete button with post2' do
      user1.follow user2
      visit root_path
      within "#post-#{post2.id}" do
        expect(page).to_not have_css ".delete-button"
      end
    end

    it 'destroy post1' do
      within "#post-#{post1.id}" do
        page.accept_confirm { find('.delete-button').click }
      end
      expect(page).to have_content '投稿を削除しました'
      expect(page).to_not have_content post1.body
    end

  end

end
