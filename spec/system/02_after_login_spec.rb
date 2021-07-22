# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '[STEP2] after login' do
  let(:user) { create(:user) }
  let!(:log) { create(:log, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'log index page' do
    before do
      visit logs_path
    end

    context 'content' do
      it 'has a correct URL' do
        expect(current_path).to eq '/logs'
      end

      it 'has all logs' do
        expect(page).to have_content log.date.strftime("%Y/%m/%d")
        expect(page).to have_content log.flight_number
      end

      it 'has a link to log detail' do
        expect(page).to have_link log.date.strftime("%Y/%m/%d"), href: log_path(log)
        expect(page).to have_link log.flight_number, href: log_path(log)
      end

      it 'has a link to favorites' do
        expect(page).to have_link 'お気に入り一覧', href: favorite_log_path
      end

      it 'has a search form' do
        expect(page).to have_button '検索'
      end
    end
  end

  describe 'log edit page' do
    before do
      visit edit_log_path(log)
    end

    context 'content' do
      it 'has a date form' do
        expect(page).to have_field 'log[date]', with: log.date.strftime("%Y-%m-%d")
      end

      it 'has a flight_number form' do
        expect(page).to have_field 'log[flight_number]', with: log.flight_number
      end

      it 'has a button to update' do
        expect(page).to have_button '編集'
      end
    end

    context 'update success' do
      before do
        @log_old_date = log.date
        @log_old_flight_number = log.flight_number
        fill_in 'log[date]', with: Faker::Time.between(from: 2.days.ago, to: Time.now)
        fill_in 'log[flight_number]', with: Faker::Number.number(digits: 2)
        click_button '編集'
      end

      it 'should update date' do
        expect(log.reload.date).not_to eq @log_old_date
      end

      it 'should update flight_number' do
        expect(log.reload.flight_number).not_to eq @log_old_flight_number
      end

      it 'redirects to log detail' do
        expect(current_path).to eq '/logs/' + log.id.to_s
      end
    end
  end

  describe 'log new page' do
    before do
      visit new_log_path
      fill_in 'log[date]', with: log.date
      fill_in 'log[flight_number]', with: log.flight_number
    end

    context 'content' do
      it 'has a date form' do
        expect(page).to have_field 'log[date]'
      end

      it 'has a flight_number form' do
        expect(page).to have_field 'log[flight_number]'
      end

      it 'has a buttoon to save' do
        expect(page).to have_button '投稿'
      end
    end

    context 'create success' do
      it 'should save log info' do
        expect { click_button '投稿' }.to change(user.logs, :count).by(1)
      end
    end

    context 'create failure' do
      it 'has a error with date form' do
        log.date = ""
        expect(log).to be_invalid
        expect(log.errors[:date]).to include("を入力してください")
      end

      it 'has a error with flight number form' do
        log.flight_number = ""
        expect(log).to be_invalid
        expect(log.errors[:flight_number]).to include("を入力してください")
      end
    end
  end

  describe 'user edit page' do
    before do
      visit edit_user_path(user)
    end

    context 'content' do
      it 'has a name form' do
        expect(page).to have_field 'user[name]', with: user.name
      end

      it 'has a email form' do
        expect(page).to have_field 'user[email]', with: user.email
      end

      it 'has a button to update' do
        expect(page).to have_button '編集内容を保存する'
      end
    end

    context 'update success' do
      before do
        @user_old_name = user.name
        @user_old_email = user.email
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        click_button '編集内容を保存する'
      end

      it 'should update name' do
        expect(user.reload.name).not_to eq @user_old_name
      end

      it 'should update email' do
        expect(user.reload.email).not_to eq @user_old_email
      end

      it 'redirects to mypage' do
        expect(current_path).to eq '/users/mypage'
      end
    end
  end
end
