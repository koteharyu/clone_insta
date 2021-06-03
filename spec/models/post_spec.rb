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
    user = create(:user)
    post = create(:post, user: user)
    
    context 'all attributes are fulled' do
      it 'returns true' do
        expect(post).to be true
      end
    end
  end
end
