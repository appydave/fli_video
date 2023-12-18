# frozen_string_literal: true

RSpec.describe FliVideo do
  it 'has a version number' do
    expect(FliVideo::VERSION).not_to be_nil
  end

  it 'has a standard error' do
    expect { raise FliVideo::Error, 'some message' }
      .to raise_error('some message')
  end
end
