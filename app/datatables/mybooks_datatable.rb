class MybooksDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Mybook.count,
        iTotalDisplayRecords: mybooks.total_entries,
        aaData: data
    }
  end

  private

  def data
    mybooks.map do |mybook|
      [
          link_to(mybook.name, mybook),
          h(mybook.mysubject),
          number_to_currency(mybook.price)
      ]
    end
  end

  def mybooks
    @mybooks ||= fetch_mybooks
  end

  def fetch_mybooks
    mybooks = Mybook.order("#{sort_column} #{sort_direction}")
    mybooks = mybooks.page(page).per_page(per_page)
    if params[:sSearch].present?
      mybooks = mybooks.where("name like :search or category like :search", search: "%#{params[:sSearch]}%")
    end
    mybooks
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name subjact price]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
