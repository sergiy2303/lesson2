require 'yaml'
require_relative '../ball'

RSpec.describe Ball do
  let(:answers) { YAML.load_file(File.join(__dir__, '../answers.yml')) }

  it 'prints the answer' do
    expect(STDOUT).to receive(:puts)
    subject.shake
  end

  it { expect(answers).to include(subject.shake) }
end
