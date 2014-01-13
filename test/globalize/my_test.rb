# encoding: utf-8

require File.expand_path('../../test_helper', __FILE__)

DEBUG = false
class MyTest < MiniTest::Spec
  describe 'model with attribute column in both model and translation table' do
    it 'does not update original columns with content not in the default locale' do
      task = Task.create :name => 'Title'
      task.translated_attribute_names # this should not make the test fail, but does
      ::DEBUG = true
      Globalize.with_locale(:de) { task.update_attributes :name => 'Titel' }

      task = Task.find(task.id)
      task.name
      legacy_task = LegacyTask.find(task.id)
      assert_equal 'Title', legacy_task.name
    end
   end
end
