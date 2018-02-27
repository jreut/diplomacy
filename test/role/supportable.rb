module Role
  module Supportable
    def test_responds_to_destination
      assert_respond_to @subject, :destination
    end
  end
end
