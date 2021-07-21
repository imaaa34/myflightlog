require 'rails_helper'

RSpec.describe '[STEP3] finishing touches' do
  let(:user) { create(:user) }
  let!(:log) { create(:log, user: user) }

  describe 'access restrictions' do
    subject { current_path }

    context 'user' do
      it 'can not access user show page' do
        visit user_path
        is_expected.to eq '/users/sign_in'
      end

      it 'can not access user edit page' do
        visit edit_user_path
        is_expected.to eq '/users/sign_in'
      end

      it 'can not access log index page' do
        visit logs_path
        is_expected.to eq '/users/sign_in'
      end

      it 'can not access log show page' do
        visit log_path(log)
        is_expected.to eq '/users/sign_in'
      end

      it 'can not access log edit page' do
        visit edit_log_path(log)
        is_expected.to eq '/users/sign_in'
      end
    end

    context 'admin' do
      it 'can not access user index page' do
        visit admins_users_path
        is_expected.to eq '/admins/sign_in'
      end

      it 'can not access user edit page' do
        visit edit_admins_user_path(user)
        is_expected.to eq '/admins/sign_in'
      end
    end
  end
end