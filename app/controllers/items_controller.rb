class ItemsController < ApplicationController
  before_filter :item_resourses, only: [:edit, :show, :update, :destroy]

  def index
    @items = Item.order('position')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: 'Item was successfully created.' }
        format.json { render json: items_path, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to items_path, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def sort
    params[:item].each_with_index do |id, index|
      Item.update_all({position: index+1}, {id: id})
    end
  end

  private

  def item_resourses
    @item = Item.find(params[:id])
  end
end
