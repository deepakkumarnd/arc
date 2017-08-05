require 'test_helper'

module TextProcessor
  describe TextProcessor do

  end

  describe String do

    it 'respond to method to_command_class' do
      assert_equal true, 'sample'.respond_to?(:to_command_class)
    end
  end
end