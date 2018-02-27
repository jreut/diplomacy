# frozen_string_literal: true

module Role
  module Order
    def test_responds_to_type
      assert_respond_to @subject, :unit
    end
  end
end
