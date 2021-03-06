require 'spec_helper'

describe Envm::EnvVar do
  describe "#required_and_missing?" do
    let(:env) { {} }

    subject(:env_var) do
      described_class.new(
        name: 'A_KEY',
        required: required_environments,
        env: env,
      )
    end

    before do
      allow(Envm::Config).to receive(:environment) { "test_env" }
    end

    context "when the required enviroment matches the Config.environment" do
      let(:required_environments) { ["test_env"] }

      context "when the key is missing from the ENV hash" do
        it "should return true" do
          expect(env_var).to be_required_and_missing
        end
      end

      context "when the key is present from the ENV hash" do
        let(:env) { { 'A_KEY' => "present" } }

        it "should return false" do
          expect(env_var).to_not be_required_and_missing
        end
      end
    end

    context "when the required enviroment matches the Config.environment" do
      let(:required_environments) { ["another_env"] }

      context "when the key is missing from the ENV hash" do
        it "should return false" do
          expect(env_var).to_not be_required_and_missing
        end
      end

      context "when the key is present from the ENV hash" do
        let(:env) { { 'A_KEY' => "present" } }

        it "should return false" do
          expect(env_var).to_not be_required_and_missing
        end
      end
    end
  end
end
