class Api::V1::AuthorsController < Api::V1::BaseController
  def index
    page = params["page"] || 1
    per_page = params["per_page"] || 10

    result = Author.order(:id).page(page).per(per_page)

    data = generate_result_data(result)
    render_success_data(data)
  end

  def show
    author_id = params[:id]

    begin
      author = Author.find(author_id)
      data = result_structure(author)
      render_success_data(data)
    rescue => e
      render_error_data(e.message, :not_found)
    end
  end

  private

  def generate_result_data(result)
    {
      authors: result.map do |author|
        result_structure(author)
      end
    }
  end

  def result_structure(data)
    {
      id: data.id,
      bio: data.bio,
      name: data.name,
      died: data.died,
      countries: data.countries,
      gender: data.gender,
      wikipedia: data.wikipedia,
      n_books: data.n_books,
      summary: data.summary,
      born: data.born,
      books: data.books.map {|x| {id: x.id, title: x.title}}
    }
  end
end
