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
    context 'when validation is ok' do
      it 'valids when name, email, password exist' do
        expect(build(:user)).to be_valid
      end
    end

    context 'when validation is NG' do
      it 'is not valid without name' do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it 'is not valid without email' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it 'is not valid without password' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("は3文字以上で入力してください")
      end

      it 'is not valid without password_confirmation' do
        user = build(:user, password_confirmation: nil)
        user.valid?
        expect(user.errors[:password_confirmation]).to include("を入力してください")
      end

      it 'is not valid when password and password_confirmation are different'do
        user = build(:user, password: "password", password_confirmation: "abc")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end

    describe 'scope :recent' do
      context '2020年4月1日から10日まで、毎日userを１人ずつ作成した場合' do
        let(:date) { Date.new(2020, 4, 1) }
        let!(:users) {  10.times {  |n| create(:user, created_at: date + n, updated_at: date + n) } }

        context 'recent(5)' do
          it 'return 5 users' do
            expect(User.recent(5).count).to eq 5
          end

          it 'number 5 users created_at is 20200406' do
            expect(User.recent(5)).to include User.find_by(created_at: '20200406')
          end

          it 'number 6 user in not including' do
            expect(User.recent(5)).to_not include User.find_by(created_at: '20200405')
          end
        end

        context 'recent(10)' do
          it 'return 10 users' do
            expect(User.recent(10).count).to eq 10
          end
        end
      end
    end
end
