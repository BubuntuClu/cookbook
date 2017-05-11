require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do

  before  do 
    @user = create(:user)
    @add_user = create(:user) 
  end

  context 'add friend' do
    before { sign_in(@user) }

    describe 'post #add_friend' do
      it 'render friend_link template', js: true do
        post :add_friend, params: { user_profile_id: @add_user.id, format: :js }
        expect(response).to render_template :friend_link
      end

      it 'adds friend to list' do
        expect { post :add_friend, params: { user_profile_id: @add_user.id, format: :js } } .to change(@user.friends_list.friends.size, :size).by(1)
      end
    end
  end

  context 'remove friend' do
    before { sign_in(@user) }

    describe 'post #remove_friend' do
      it 'render friend_link template', js: true do
        post :add_friend, params: { user_profile_id: @add_user.id, format: :js }
        post :remove_friend, params: { user_profile_id: @add_user.id, format: :js }
        expect(response).to render_template :friend_link
      end

      it 'render remove_friend template when type is present', js: true do
        post :add_friend, params: { user_profile_id: @add_user.id, format: :js }
        post :remove_friend, params: { user_profile_id: @add_user.id, format: :js, type: 'friends_list' }
        expect(response).to render_template :remove_friend
      end

      it 'adds friend to list' do
        post :add_friend, params: { user_profile_id: @add_user.id, format: :js }
        expect { post :remove_friend, params: { user_profile_id: @add_user.id, format: :js } } .to change(@user.friends_list.friends.size, :size).by(-1)
      end
    end
  end
end
