class Api::V1::BooksController < Api::V1::BaseController
  def index
    page = params["page"] || 1
    per_page = params["per_page"] || 10

    author_name = params[:author_name]
    years = params[:years]
    min_page = params[:min_page]
    max_page = params[:max_page]

    query = Book.all

    if author_name.present?
      author_ids = Author.where(name: author_name.split(",")).pluck(:id)
      query = query.joins(:authors).merge(Author.where(id: author_ids))
    end

    query = query.where(year: years) if years.present?
    query = query.where('pages >= ?', min_page) if min_page.present?
    query = query.where('pages <= ?', max_page) if max_page.present?
    query = query.where('pages BETWEEN ? AND ?', min_page, max_page) if min_page.present? && max_page.present?

    result = query.page(page).per(per_page)
    data = generate_result_data(result)

    render_success_data(data)
  end

  def show
    book_id = params[:id]

    begin
      book = Book.find(book_id)
      data = result_structure(book)
      render_success_data(data)
    rescue => e
      render_error_data(e.message, :not_found)
    end
  end

  def find_similar
    book_id = params[:id]

    begin
      book = Book.find(book_id)
      data = {
        id: book_id,
        similar_books: book.similar_books.values.flatten
      }
      render_success_data(data)
    rescue => e
      render_error_data(e.message, :not_found)
    end
  end

  private

  def generate_result_data(result)
    {
      books: result.map do |book|
        result_structure(book)
      end
    }
  end

  def result_structure(data)
    {
      id: data.id,
      title: data.title,
      original_title: data.original_title,
      authors: data.authors.map {|x| {id: x.id, name: x.name}},
      pages: data.pages,
      year: data.year,
      content_name: data.content_name,
      isbn: data.isbn,
      images_urls: data.image_urls.map {|x| x.url},
      language_code: data.language_code,
      images: data.images.map {|x| x.image_url},
      category: data.category,
      plot: data.plot,
      copyright: data.copyright,
      wikipedia: data.wikipedia,
      average_rating: data.average_rating,
      rating_count: data.rating_count,
      goodreads: data.goodreads,
      similar_books: data.similar_books.values.flatten,
      description: data.description,
      loc_class: data.loc_class,
      gutenberg: data.gutenberg,
      language: data.language,
      isbn13: data.isbn13,
      countries: data.countries,
      release_date: data.release_date,
      cover: data.cover,
      summary: data.summary,
      classes: data.classes.map {|x| x.name},
      content_cleaned: data.content_cleaned,
      content_available: data.content_available,
      contents: data.book_contents,
      n_authors: data.n_authors
    }
  end
end
