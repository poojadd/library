class BookUsersController < ApplicationController



  def new
    @bookuser = BookUser.new
    render :action => "new"
  end

  def index

    # @boo = Mybook.joins("left outer join book_users on book_users.mybook_id = mybooks.id").where("book_users.id is not null")
     @bookusers =  BookUser.where("returned = ?", false )

  end

  def return

    @bookuser = BookUser.find(params[:format])
    p @bookuser
    @bookuser.returned = true

    respond_to do |format|
      if  @bookuser.update_attributes(:returned => true)

        format.html { redirect_to(book_users_path, :notice => 'Book was successfully returned.') }
      end
    end
  end

  def destroy
    p params[:id]
    BookUser.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to book_users_path  }

    end
  end
  def create

    @bookuser = BookUser.new(params[:bookuser])
    @bookuser.user_id = params[:user][:user_id]
    @bookuser.mybook_id = params[:book_user][:mybook_id]
    @bookuser.issuedate = DateTime.now
    @bookuser.returndate = 15.day.from_now
    @bookuser.returned = false
    respond_to do |format|
      if @bookuser.save
        format.html { redirect_to(mybooks_path, :notice => 'Book was successfully issued.') }
        format.js   {render :file => '/mybooks/index.js.erb' }

      else
        @mysubjects = Mysubject.all
        format.html { render :action => "mybooks_path" }
        format.js

      end
    end
  end
end
