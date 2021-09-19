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

    data = {
      books: result.map do |book|
        {
          id: book.id,
          title: book.title,
          original_title: book.original_title,
          authors: book.authors.map {|x| x.name},
          pages: book.pages,
          year: book.year,
          content_name: book.content_name,
          isbn: book.isbn,
          images_urls: book.image_urls.map {|x| x.url},
          language_code: book.language_code,
          images: book.images.map {|x| x.image_url},
          category: book.category,
          plot: book.plot,
          copyright: book.copyright,
          wikipedia: book.wikipedia,
          average_rating: book.average_rating,
          rating_count: book.rating_count,
          goodreads: book.goodreads,
          similar_books: book.similar_books.values.flatten,
          description: book.description,
          loc_class: book.loc_class,
          gutenberg: book.gutenberg,
          language: book.language,
          isbn13: book.isbn13,
          countries: book.countries,
          release_date: book.release_date,
          cover: book.cover,
          summary: book.summary,
          classes: book.classes.map {|x| x.name},
          content_cleaned: book.content_cleaned,
          content_available: book.content_available,
          contents: book.book_contents,
          n_authors: book.n_authors
        }
      end
    }

    render_success_data(data)
  end

  def show
    book_id = params[:id]

    begin
      book = Book.find(book_id)
      data = {
        id: book.id,
        title: book.title,
        original_title: book.original_title,
        authors: book.authors.map {|x| x.name},
        pages: book.pages,
        year: book.year,
        content_name: book.content_name,
        isbn: book.isbn,
        images_urls: book.image_urls.map {|x| x.url},
        language_code: book.language_code,
        images: book.images.map {|x| x.image_url},
        category: book.category,
        plot: book.plot,
        copyright: book.copyright,
        wikipedia: book.wikipedia,
        average_rating: book.average_rating,
        rating_count: book.rating_count,
        goodreads: book.goodreads,
        similar_books: book.similar_books.values.flatten,
        description: book.description,
        loc_class: book.loc_class,
        gutenberg: book.gutenberg,
        language: book.language,
        isbn13: book.isbn13,
        countries: book.countries,
        release_date: book.release_date,
        cover: book.cover,
        summary: book.summary,
        classes: book.classes.map {|x| x.name},
        content_cleaned: book.content_cleaned,
        content_available: book.content_available,
        contents: book.book_contents,
        n_authors: book.n_authors
      }

      render_success_data(data)
    rescue => e
      render_error_data(e.message)
    end
  end
end
