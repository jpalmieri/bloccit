describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        v1 = Vote.new(value: 1)
        v2 = Vote.new(value: -1)
        v3 = Vote.new(value: 2)

        expect ( v1.valid? && v2.valid? && !v3.valid? ).to eq(true)

        end

      end
    end
  end
end