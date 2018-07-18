require 'test_helper'

class Translate < ActiveSupport::TestCase
  def test_translate
    assert_equal("n. 英格兰；英国", Address.translate("England").parsed_response["basic"]["explains"].join)
  end
end
