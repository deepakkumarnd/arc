require 'test_helper'

describe Api::V1::TextOperationsController do

  describe '#run_commands' do

    let(:api_path) { '/api/v1/text_operations/run_commands' }

    it 'Returns error if no commands are provided' do
      post api_path
      assert_equal 'no_commands', response_body['status']
      assert_equal 'No commands are provided.', response_body['message']
    end

    it 'Returns error if the input is empty' do
      post api_path, params: { commands: 'sort' }
      assert_equal 'empty_input', response_body['status']
      assert response_body['message']
    end

    it 'Returns error if an upsupported command is provided' do
      post api_path, params: { commands: 'test', text: 'Lorem epsum' }
      assert_equal 'command_error', response_body['status']
      assert response_body['message']
    end

    it 'Sorts the given lines' do
      post api_path, params: { commands: 'sort|', text: "ann\ndeepak\ndavid\narjun\nsandhya\nbibin" }
      assert_equal "ann\narjun\nbibin\ndavid\ndeepak\nsandhya", response_body['data']
    end

    it 'Sorts and returns the uniq items' do
      post api_path, params: { commands: 'sort|uniq', text: "orange\napple\norange\ncherry" }
      assert_equal "apple\ncherry\norange", response_body['data']
    end

    it 'Splits the text into lines' do
      post api_path, params: { commands: 'split', text: " apple   cherry   orange " }
      assert_equal "apple\ncherry\norange", response_body['data']
    end
  end
end