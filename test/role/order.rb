module Role
  module Order
    def test_responds_to_type
      assert_respond_to @subject, :unit
    end

    def test_provinces_is_enumerable
      assert_respond_to @subject.provinces, :each
    end
  end
end
