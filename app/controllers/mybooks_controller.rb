class MybooksController < ApplicationController

  before_filter :authenticate_user, :except => [:list, :index, :show]

  load_and_authorize_resource

  def list
    #@book = BookUser.where(:returned =>  0)
  #  @issuebooks = Mybook.where (Mybook.id in)

  end

  def index

    @bookuser = BookUser.new

     @mybooks = Mybook.availables
    respond_to do |format|
      format.html
      format.json { render j  son: MybooksDatatable.new(view_context) }
      format.js { render :file => '/mybooks/index.js.erb' }
    end
  end

  def show
    @mybook = Mybook.find(params[:id])

  end

  def new
    @mybook = Mybook.new


  end

  def create
    @mybook = Mybook.new(params[:mybook])
    respond_to do |format|
      if @mybook.save
        format.html { redirect_to(mybooks_path, :notice => 'Post was successfully created.') }
        format.js

      else
        @mysubjects = Mysubject.all
        format.html { render :action => "new" }
        format.js

      end
    end
  end

  def search
    @mybooks = Mybook.search params[:search]
    respond_to do |format|
      format.html { render :action => "index" }
    end
  end

  def edit
    @mybook = Mybook.find(params[:id])
    @mysubjects = Mysubject.all
  end

  def update
    @mybook = Mybook.find(params[:id])
    respond_to do |format|
      if @mybook.update_attributes(params[:mybook])
        format.html { redirect_to(mybooks_path, :notice => 'Book was successfully updated.') }

      else
        @mysubjects = Mysubject.all
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    Mybook.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to mybooks_url }
      format.js { render :nothing => true }
    end
  end

  def show_mysubjects
    @subject = Mysubject.find(params[:id])
  end


  load_and_authorize_resource
end

=begin

pooja@pooja-Lenovo-G550:~/RubymineProjects/mylibrary$ rake routes
  mybooks_list GET    /mybooks/list(.:format)        mybooks#list
       mybooks GET    /mybooks(.:format)             mybooks#index
               POST   /mybooks(.:format)             mybooks#create
    new_mybook GET    /mybooks/new(.:format)         mybooks#new
   edit_mybook GET    /mybooks/:id/edit(.:format)    mybooks#edit
        mybook GET    /mybooks/:id(.:format)         mybooks#show
               PUT    /mybooks/:id(.:format)         mybooks#update
               DELETE /mybooks/:id(.:format)         mybooks#destroy


    mysubjects GET    /mysubjects(.:format)          mysubjects#index
               POST   /mysubjects(.:format)          mysubjects#create
 new_mysubject GET    /mysubjects/new(.:format)      mysubjects#new
edit_mysubject GET    /mysubjects/:id/edit(.:format) mysubjects#edit
     mysubject GET    /mysubjects/:id(.:format)      mysubjects#show
               PUT    /mysubjects/:id(.:format)      mysubjects#update
               DELETE /mysubjects/:id(.:format)      mysubjects#destroy
          root        /                              mybooks#list


=end
