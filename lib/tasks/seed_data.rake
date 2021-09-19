require 'json'

desc "Seeding sample data"
task seed_data: :environment do
  country_file = File.read(File.join(__dir__, 'countries.json'))
  countries_data = JSON.parse(country_file)["countries"]

  puts "Seeding author data"
  author_file = File.read(File.join(__dir__, 'authors.json'))
  authors_data = JSON.parse(author_file)["authors"]

  authors = []
  authors_data.each do |author_data|
    author = Author.new
    author.name = author_data["name"]
    author.bio = author_data["bio"]
    author_countries = []
    author_data["countries"].each do |country_id|
      country = countries_data.find{|country| country["id"] == country_id}
      author_countries << country["name"]
    end
    author.countries = author_countries.join(", ")
    author.gender = author_data["gender"]
    author.wikipedia = author_data["wikipedia"]
    author.n_books = author_data["n_books"]
    author.summary = author_data["summary"]
    author.born = author_data["born"]
    author.died = author_data["died"]

    authors << author
  end
  Author.import(authors)

  puts "Seeding book data"
  book_file = File.read(File.join(__dir__, 'books.json'))
  books_data = JSON.parse(book_file)["books"].sort_by {|x| x["id"]}

  classes = books_data.map {|x| x["classes"]}.flatten.uniq
  book_classes = []

  classes.each do |name|
    book_classes << ClassBook.new(name: name)
  end
  ClassBook.import(book_classes)

  books_data.each do |book_data|
    book = Book.new
    book.content_name = book_data["content_name"]
    book.isbn = book_data["isbn"]
    book.original_title = book_data["original_title"]
    book.year = book_data["year"]
    book.language_code = book_data["language_code"]
    book.category = book_data["category"]
    book.plot = book_data["plot"]
    book.copyright = book_data["copyright"]
    book.title = book_data["title"]
    book.wikipedia = book_data["wikipedia"]
    book.average_rating = book_data["average_rating"]
    book.rating_count = book_data["rating_count"]
    book.goodreads = book_data["goodreads"]
    book.description = book_data["description"]
    book.loc_class = book_data["loc_class"]
    book.gutenberg = book_data["gutenberg"]
    book.pages = book_data["pages"]
    book.language = book_data["language"]
    book.isbn13 = book_data["isbn13"]

    book_countries = []
    book_data["countries"].each do |country_id|
      country = countries_data.find{|country| country["id"] == country_id}
      book_countries << country["name"]
    end
    book.countries = book_countries.join(", ")

    book.release_date = book_data["release_date"]
    book.cover = book_data["cover"]
    book.summary = book_data["summary"]
    book.content_cleaned = book_data["content_cleaned"]
    book.content_available = book_data["content_available"]
    book.n_authors = book_data["n_authors"]

    book.save!

    book_authors = []
    book_data["authors"].each do |author_id|
      book_author = BookAuthor.new
      book_author.book_id = book.id
      book_author.author_id = author_id
      book_authors << book_author
    end
    BookAuthor.import(book_authors)

    if book_data["contents"].present?
      contents = []
      book_data["contents"].each do |content|
        book_content = BookContent.new
        book_content.book_id = book.id
        book_content.author_id = content["author"]
        book_content.title = content["title"]
        contents << book_content
      end
      BookContent.import(contents)
    end

    if book_data["images_urls"].present?
      images_urls = []
      book_data["images_urls"].each do |url|
        image_url = ImageUrl.new
        image_url.book_id = book.id
        image_url.url = url
        images_urls << image_url
      end
      ImageUrl.import(images_urls)
    end

    if book_data["images"].present?
      images = []
      book_data["images"].each do |image|
        image = Image.new
        image.book_id = book.id
        image.image_url = image
        images << image
      end
      Image.import(images)
    end

    if book_data["classes"].present?
      book_classes = []
      book_data["classes"].each do |name|
        book_class = BookClass.new
        book_class.book_id = book.id
        book_class.class_book_id = ClassBook.find_by(name: name).try(:id)
        book_classes << book_class
      end
      BookClass.import(book_classes)
    end
  end

  books_data.each do |book_data|
    similar_books = []
    if book_data["similar_books"].present?
      book_data["similar_books"].each do |title|
        similar_book = SimilarBook.new
        similar_book.book_id = book_data["id"]
        similar_book.similar_book_id = Book.find_by(title: title).try(:id)
        similar_books << similar_book
      end
      SimilarBook.import(similar_books)
    end
  end
end
