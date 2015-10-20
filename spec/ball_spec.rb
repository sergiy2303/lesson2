require 'yaml'
require_relative '../ball'

RSpec.describe Ball do
  let(:answers) { YAML.load_file(File.join(__dir__, '../answers.yml')) }

  it { expect(answers.values.flatten).to include(subject.shake) }
  it { expect(answers).to eql(Ball::ANSWERS) }

  describe '#shake' do
    before { stub_const('Ball::ANSWERS', red: ['ANSWER']) }

    it 'prints colorized answer' do
      expect(STDOUT).to receive(:puts).with("\e[31mANSWER\e[0m")
      subject.shake
    end
  end
end
