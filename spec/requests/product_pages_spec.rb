require 'spec_helper'

describe "Product Pages" do
	subject { page }
  
  describe "index" do
  	before {visit products_path}

    it { should have_content('Produto') }
    it { should have_link('Remover todos selecionados', href: destroy_selected_products_path) }
    it { should have_link('Ativar todos selecionados', href: ativate_selected_products_path) }
    it { should have_link('Desativar todos selecionados', href: deactivate_selected_products_path) }
    it { should have_link('Novo Produto', href: new_product_path) }

    before(:all) { category = FactoryGirl.create_list(:category, 3) }
    after(:all)  { Category.delete_all }

    let(:categorie_select) { Category.first }

    before do
    	select(categorie_select.name, :from => 'categoria') 
    end

    it { should have_selector('th', text: "Todos") }
    it { should have_selector('th', text: "Nome") }
    it { should have_selector('th', text: "Ativo") }
    it { should have_selector('th', text: "Categoria") }

    describe "product list" do
    	
      before(:all) { 3.times { FactoryGirl.create(:product) } } 
      after(:all)  { Product.delete_all}
    	
      it { should have_link('Editar', href: edit_product_path(Product.first)) }

      describe "delete links" do

        before { FactoryGirl.create(:product) }
        
        before { visit products_path }
      
        it { should have_link("Deletar", href: product_path(Product.first)) }

        it "should be able to delete the product" do
          expect do
            click_link("Deletar", match: :first)
          end.to change(Product, :count).by(-1)
        end
      end
    end
  end

  describe "show" do
    let(:product) { FactoryGirl.create(:product) }
    before { visit product_path(product) }

    it { should have_selector('h1', text: 'Produto') }
    it { should have_selector('strong', text: 'Nome:') }
    it { should have_selector('strong', text: 'Situação:') }
    it { should have_selector('strong', text: 'Categoria:') }

    it { should have_content(product.name) }
    it { should have_content(product.ativo_inativo) }
    it { should have_content(product.category.name) }

    it { should have_link('Novo', href: new_product_path) }
    it { should have_link('Editar', href: edit_product_path(product)) }
    it { should have_link('Voltar', href: products_path) }
  end

  describe "new product" do
    before { visit new_product_path  }
    
    it { should have_selector('h1', text: 'Novo Produto') }
    it { should have_link('Cancelar', href: products_path) }

    let(:submit) { "Salvar" }

    describe "with invalid information" do
      it "should not create a product" do
        expect { click_button submit }.not_to change(Product, :count)
      end
    end

    describe "with valid information" do
	    before(:all) {category = FactoryGirl.create_list(:category, 1)}
	    after(:all)  {Category.delete_all}
      let(:new_category)        { Category.first }
      before do
        fill_in "Nome",           with: "Example Product"
        select(new_category.name, from: 'product_category_id')
        check('product_active')
      end

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end

      describe "after saving the product" do
        before { click_button submit }
        
        it { should have_selector('p', text: 'created') }
      end
    end
    
  end  

  describe "edit" do
    let(:product) { FactoryGirl.create(:product) }
      
    before { visit edit_product_path(product) }
    
    it { should have_content('Editar Produto') }
    it { should have_link('Cancelar', href: products_path) }

    describe "with valid information" do
      before do 
        fill_in "Nome",         with: ""
        click_button "Salvar"
      end
      it { should have_content("error") }
    end

    describe "with valid information" do

      let(:new_name)   { 'Edit Product' }
      let(:new_category) { Category.last }

      before(:all) { category         = FactoryGirl.create_list(:category, 3) }
      after(:all)  { Category.delete_all }

      before do
        fill_in "Nome",            with: new_name
        select(new_category.name,  from: 'product_category_id')
        check('product_active')
        click_button 'Salvar'
      end
      
      it { should have_selector('p', text: 'update') }
      specify { expect(product.reload.name).to  eq new_name }
    end

  end

end
