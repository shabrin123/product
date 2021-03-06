class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :category_product_list]

  # GET /categories
  # GET /categories.json
  def index
    @search = Category.search(params[:query] || {})
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    @categories = @search.result.paginate(:per_page => 15, :page => params[:page]).order("updated_at desc")
  #  @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def category_product_list
    @search = @category.products.search(params[:query] || {})
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    @products = @search.result.paginate(:per_page => 15, :page => params[:page]).order("updated_at desc")     
   #  @products=@category.products
      render :template => "products/index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :description, :image)
    end
end
