class TagsController < ApplicationController
  def index
    @taggable = find_taggable
    @tags = @taggable.tags
  end

  def create
       @taggable = find_taggable
    @tag = @taggable.tags.build(params[:tag])
       respond_to do |format|
         if @tag.save
           format.js { render :file => '/tags/index.js.erb' }
         else
           render :action =>  'new'
         end
       end

  end
  def show
    @taggable = find_taggable
    p @taggable
    @tags = @taggable.tags

  end
  private

  def find_taggable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
