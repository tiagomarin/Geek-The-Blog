require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before publication' do # (almost) plain English
    it 'cannot have comments' do #
      expect { Post.create.comments.create! }.to raise_error(ActiveRecord::RecordInvalid) # test code
    end
  end
end
