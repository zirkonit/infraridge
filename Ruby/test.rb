require_relative './register'

context "change" do
  before :each do
    @reg = Register.new()
  end

  it "shows the change" do
    @reg.state = [1, 2, 3, 4, 5]
    expect(@reg.show).to eq("$68 1 2 3 4 5")
  end

  it "puts the money in" do
    expect(@reg.put(["1", "2", "3", "4", "5"])).to eq("$68 1 2 3 4 5")
    expect(@reg.put(["1", "2", "3", "4", "5"])).to eq("$136 2 4 6 8 10")
  end

  it "takes the money out" do
    @reg.state = [1, 2, 3, 4, 5]
    expect(@reg.take(["0", "0", "1", "1", "1"])).to eq("$60 1 2 2 3 4")
    expect(@reg.take(["1", "2", "3", "4", "5"])).to eq("Register doesn't have so much money")
  end

  it "calculates the change" do
    @reg.state = [1, 0, 3, 4, 0]
    expect(@reg.show).to eq("$43 1 0 3 4 0")
    expect(@reg.change("11")).to eq("0 0 1 3 0")
    expect(@reg.show).to eq("$32 1 0 2 1 0")
    expect(@reg.change("14")).to eq("sorry")
  end
end
