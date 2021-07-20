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

  describe 'user sign up page' do
    before do
      visit new_user_registration_path
    end

    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/users/sign_up'
      end

      it 'has a name form' do
        expect(page).to have_field 'user[name]'
      end

      it 'has an email form' do
        expect(page).to have_field 'user[email]'
      end

      it 'has a password form' do
        expect(page).to have_field 'user[password]'
      end

      it 'has a password_confirmation form' do
        expect(page).to have_field 'user[password_confirmation]'
      end

      it 'has a sign up button' do
        expect(page).to have_button '新規登録'
      end
    end

    context 'sign up success' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it 'users info is saved' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end

      it 'redirects to logs page' do
        click_button '新規登録'
        expect(current_path).to eq '/logs'
      end
    end
  end

  describe 'user login page' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/users/sign_in'
      end

      it 'has an email form' do
        expect(page).to have_field 'user[email]'
      end

      it 'has a password form' do
        expect(page).to have_field 'user[password]'
      end

      it 'has a login button' do
        expect(page).to have_button 'ログイン'
      end

      it 'does not have a name form' do
        expect(page).not_to have_field 'user[name]'
      end
    end

    context 'login success' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'redirects to logs page' do
        expect(current_path).to eq '/logs'
      end
    end

    context 'login failure' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'redirects to login page' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'admin login page' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
    end

    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/admins/sign_in'
      end

      it 'has an email form' do
        expect(page).to have_field 'admin[email]'
      end

      it 'has a password form' do
        expect(page).to have_field 'admin[password]'
      end

      it 'has a login button' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'login success' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
      end

      it 'redirects to users page' do
        expect(current_path).to eq '/admins/users'
      end
    end

    context 'login failure' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
      end

      it 'redirects to login page' do
        expect(current_path).to eq '/admins/sign_in'
      end
    end
  end

  describe 'header after user login' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'content' do
      it 'has a link to mypage' do
        expect(page).to have_link "", href: user_path
      end

      it 'has a link to logs' do
        expect(page).to have_link "", href: logs_path
      end

      it 'has a link to stats' do
        expect(page).to have_link "", href: stats_log_path
      end

      it 'has a link to logout' do
        expect(page).to have_link "", href: destroy_user_session_path
      end
    end
  end

  describe 'header after admin login' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    context 'content' do
      it 'has a link to users' do
        expect(page).to have_link "", href: admins_users_path
      end

      it 'has a link to logout' do
        expect(page).to have_link "", href: destroy_admin_session_path
      end
    end
  end

  describe 'footer after user login' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'content' do
      it 'has a link to contact' do
        expect(page).to have_link "", href: new_contact_path
      end
    end
  end

  describe 'footer after admin login' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    context 'content' do
      it 'does not have a link to contact' do
        expect(page).not_to have_link "", href: new_contact_path
      end
    end
  end
end
