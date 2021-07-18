# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do

    subject { user.valid? }
    let!(:user) { create(:user) }

    context 'name' do
      it 'is not empty' do
        user.name = ""
        is_expected.to eq false
        expect(user.errors[:name]).to include("を入力してください")
      end

      it 'is not less than 1' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it 'is more than 2' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
    end

    context 'email' do
      it 'is not empty' do
        user.email = ""
        is_expected.to eq false
      end
    end

  end
end
