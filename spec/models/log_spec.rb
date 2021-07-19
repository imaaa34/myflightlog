# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Log, type: :model do
  describe 'validation' do

    subject { log.valid? }
    let!(:log) { create(:log) }

    context 'date' do
      it 'is not empty' do
        log.date = ""
        is_expected.to eq false
        expect(log.errors[:date]).to include("を入力してください")
      end
    end

    context 'flight_number' do
      it 'is not empty' do
        log.flight_number = ""
        is_expected.to eq false
        expect(log.errors[:flight_number]).to include("を入力してください")
      end
    end

    context 'departure_airport' do
      it 'includes "空港"' do
        log.departure_airport = Faker::String.random(length: 4)
        is_expected.to eq false
        expect(log.errors[:departure_airport]).to include("「〇〇空港」という形式で入力してください。");
      end
    end

    context 'arrival_airport' do
      it 'includes "空港"' do
        log.arrival_airport = Faker::String.random(length: 4)
        is_expected.to eq false
        expect(log.errors[:arrival_airport]).to include("「〇〇空港」という形式で入力してください。");
      end
    end

    context 'comment' do
      it 'is not more than 201' do
        log.comment = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end

      it 'is less than 200' do
        log.comment = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
    end
  end

  describe 'association' do
    context 'relationship with User' do
      it 'N:1' do
        expect(Log.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end