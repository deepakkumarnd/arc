require 'test_helper'

describe Api::V1::TextOperationsController do

  describe '#run_commands' do

    let(:api_path) { '/api/v1/text_operations/run_commands' }

    it 'Returns error if no commands are provided' do
      post api_path
      assert_equal 'no_commands', response_body['status']
    end

    it 'Returns error if an upsupported command is provided' do
      post api_path, params: { commands: 'test' }
      assert_equal 'command_error', response_body['status']
    end
  end
end