# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validation' do
    subject { contact.valid? }

    let!(:contact) { create(:contact) }

    context 'name' do
      it 'is not empty' do
        contact.name = ""
        is_expected.to eq false
        expect(contact.errors[:name]).to include("を入力してください")
      end

      it 'is not less than 1' do
        contact.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end

      it 'is more than 2' do
        contact.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
    end

    context 'email' do
      it 'is not empty' do
        contact.email = ""
        is_expected.to eq false
        expect(contact.errors[:email]).to include("を入力してください")
      end
    end

    context 'content' do
      it 'is not empty' do
        contact.content = ""
        is_expected.to eq false
        expect(contact.errors[:content]).to include("を入力してください")
      end

      it 'is not more than 301' do
        contact.content = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end

      it 'is less than 300' do
        contact.content = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
    end
  end
end
