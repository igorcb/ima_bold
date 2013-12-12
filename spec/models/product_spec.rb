require 'spec_helper'

describe Product do
	let(:category) { FactoryGirl.create(:category) }
  before { @product = Product.new(name: "Mouse USB", active: true, category_id: category.id) }

  subject { @product }

  it { should respond_to(:name) }
  it { should respond_to(:active) }
  it { should respond_to(:category_id) }
  it { should respond_to(:category)}

  it { should be_valid }

  describe "when name is not present" do
  	before { @product.name = " "}
  	it { should_not be_valid}
  end

  describe "when active is not present" do
  	before { @product.active = " "}
  	it { should_not be_valid}
  end

  describe "when category_id is not present" do
  	before { @product.category_id = " "}
  	it { should_not be_valid}
  end

  describe "with name that is too long" do
    before { @product.name = "a" * 31 }
    it { should_not be_valid }
  end

end

