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
      end
    end
  end
end
