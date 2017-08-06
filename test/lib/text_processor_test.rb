require 'test_helper'

module TextProcessor
  describe TextProcessor do

  end

  describe String do

    it 'respond to method to_command_class' do
      assert_equal true, 'sample'.respond_to?(:to_command_class)
    end

    it 'returns the Sort command' do
      assert_equal Sort, 'sort'.to_command_class
    end

    it 'returns the uniq lines in the list' do
      assert_equal "bar\nfoo\nnote", Uniq.exec("foo\nbar\nfoo\nnote")
    end

    it 'sorts the input lines' do
      assert_equal "bar\nfoo", Sort.exec("foo\nbar")
    end

    it 'splits the text into lines' do
      assert_equal "foo\nbar", Split.exec("foo    bar")
    end

  end
end