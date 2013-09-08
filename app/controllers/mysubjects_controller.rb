class MysubjectsController < ApplicationController

  before_filter :authenticate_user, :except => [:list, :index, :show]

  def index
    @mysubjects = Mysubject.paginate(:page => params[:page])
    @mysubject = Mysubject.new
    p "." * 100
    p Rails.root
    respond_to do |format|
      format.html
      format.js { render :file => '/mysubjects/index.js.erb' }
    end
  end


  def new
    @mysubject = Mysubject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mysubject }
      format.js
    end
  end

  def edit
    @mysubject = Mysubject.find(params[:id])
  end


  def create
    @mysubject = Mysubject.new(params[:mysubject])

    respond_to do |format|
      if @mysubject.save
        @mysubjects = Mysubject.find(:all)
        p @mysubjects.size
        format.html { redirect_to mysubjects_path, notice: 'Mysubject was successfully created.' }
        format.json { render json: mysubjects_path, status: :created, location: @mysubject }
        format.js { render :file => '/mysubjects/index.js.erb' }
      else
        format.html { render action: "new" }
        format.json { render json: @mysubject.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @mysubject = Mysubject.find(params[:id])

    respond_to do |format|
      if @mysubject.update_attributes(params[:mysubject])
        format.html { redirect_to mysubjects_path, notice: 'Mysubject was successfully updated.' }
        format.json { render json: mysubjects_path, status: :created, location: @mysubject }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @mysubject.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def list
    @mysubjects = Mysubject.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mysubjects }
      format.js
    end
  end


  def destroy
    @mysubject = Mysubject.find(params[:id])
    @mysubject.destroy

    respond_to do |format|
      format.html { redirect_to mysubjects_url }
      format.json { head :no_content }
      format.js
    end
  end

  def show
    @mysubject = Mysubject.find(params[:id])

  end

  load_and_authorize_resource
end
