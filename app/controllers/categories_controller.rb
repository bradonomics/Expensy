class CategoriesController < ApplicationController

  # lets user view expense categories if logged in
  get '/categories' do
    @categories = Category.all
    erb :'categories/categories'
  end

  # does not let a user create a blank category
  post '/categories' do
    if params[:name].empty?
      flash[:message] = "Please Enter a Category Name"
      redirect_to_categories
    else
      @category = Category.create(name:params[:name])
      redirect_to_categories
    end
  end

  # displays a single category
  get '/categories/:id' do
    @category = Category.find(params[:id])
    erb :'categories/show_category'
  end

  # lets a user view category edit form if they are logged in
  # does not let a user edit a category not created by it self
  get '/categories/:id/edit' do
    @category = Category.find(params[:id])
    erb :'categories/edit_category'
  end

  # does not let a user edit a category with blank content
  patch '/categories/:id' do
    if !params[:name].empty?
      @category = Category.find(params[:id])
      @category.update(name:params[:name])
      flash[:message] = "Your category has been updated successfully"
      redirect_to_categories
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/categories/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own category if they are logged in
  # does not let a user delete a category they did not create
  delete '/categories/:id/delete' do
    if categories.size == 1
      flash[:message] = "You need at least one category"
      redirect_to_categories
    else
      @category = Category.find(params[:id])
      @category.destroy
      flash[:message] = "Your category has been deleted successfully"
      redirect_to_categories
    end
  end

  helpers do

    def total_amount(array)
      array.expenses.collect { |expense| expense.amount }.sum
    end

  end

end
