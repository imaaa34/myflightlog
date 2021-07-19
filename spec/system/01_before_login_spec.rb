# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '[STEP1] before login' do
  describe 'top page' do
    before do
      visit root_path
    end

    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/'
      end

      it 'has a link to sign up' do
        click_link '新規登録'
        expect(current_path).to eq new_user_registration_path
      end

      it 'has a link to login' do
        click_link 'ログイン'
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'about page' do
    before do
      visit about_path
    end

    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/about'
      end
    end
  end


  describe 'sign up page' do
    before do
      visit new_user_registration_path
    end


    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/users/sign_up'
      end
    end
  end
end