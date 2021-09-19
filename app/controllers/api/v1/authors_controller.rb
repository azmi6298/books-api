class Api::V1::AuthorsController < Api::V1::BaseController
  def index
    page = params["page"] || 1
    per_page = params["per_page"] || 10

    query = Author.all
    result = query.page(page).per(per_page)

    data = {
      authors: result.map do |author|
        {
          id: author.id,
          bio: author.bio,
          name: author.name,
          died: author.died,
          countries: author.countries,
          gender: author.gender,
          wikipedia: author.wikipedia,
          n_books: author.n_books,
          summary: author.summary,
          born: author.born,
          books: author.books.map {|x| x.id}
        }
      end
    }

    render_success_data(data)
  end

  def show
    author_id = params[:id]

    begin
      author = Author.find(author_id)
      data = {
          id: author.id,
          bio: author.bio,
          name: author.name,
          died: author.died,
          countries: author.countries,
          gender: author.gender,
          wikipedia: author.wikipedia,
          n_books: author.n_books,
          summary: author.summary,
          born: author.born,
          books: author.books.map {|x| x.id}
      }

      render_success_data(data)
    rescue => e
      render_error_data(e.message)
    end
  end
end
