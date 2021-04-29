[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
[![book-worm-2010](https://circleci.com/gh/book-worm-2010/book-worm-be.svg?style=svg)](https://github.com/book-worm-2010/book-worm-be)
<!-- [![Forks][forks-shield]][forks-url] -->
<!-- [![Stargazers][stars-shield]][stars-url] -->

# book-worm-be

### About this App

book-worm-be is the server-side application of [BookWorm](https://book-worm-2.herokuapp.com/home). It stores some information on users and the books they are reading as well as their 'bookmarks'. This app consumes the Google Books API and exposes relevant information for the [front-end](https://github.com/book-worm-2010/book-worm-fe) side of BookWorm. 


### Goals accomplished
Consumed Google Books API 
Robust unit and integration testing to ensure data quality  
Navigate working together with a larger application base with many moving parts  
Learned application design from the perspective of users' needs  
Setup continuous integration and deployment with CircleCI  
Deployed on Heroku(see endpoints)


## Versions

- Ruby 2.7.1

- Rails 6.1.3.1



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#schema">Schema</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
### Built With

* [Ruby](https://www.ruby-lang.org/en/)
* [Ruby on Rails](https://github.com/rails/rails)

<!-- GETTING STARTED -->
## Getting Started

### Installation

1. Fork and Clone the repo
   ```
   git clone git@github.com:book-worm/book-worm-be.git
   ```
2. Install gems
   ```
   bundle install
   ```
3. Setup the database: 
   ```
   rails db:setup
   ```

## Endpoints

### Student Info
**GET** `https://book-worm-be.herokuapp.com/api/v1/students/login`  
*{"email": "example@gmail.com",*
 *"name": "Example Student"}*
 
### Student's Books
**GET** `https://book-worm-be.herokuapp.com/api/v1/students/books` 
*{"id": "123",*
*"status": "reading"}*
*status options - 'reading', 'finished', 'abandoned'*
*no status defaults to all books*

### Search Books
**GET** `https://book-worm-be.herokuapp.com/api/v1/books` 
*{"title": "Harry Potter and the Sorcerer's Stone",*
*"author": "J. K. Rowling"}*

### Add Book to Student
**POST** `https://book-worm-be.herokuapp.com/api/v1/student_books`
*{"student_id": 1,
  "prediction": "This is my prediction",
  "book": {
  "title": "Harry Potter and the Goblet of Fire",
  "author": "J.K. Rowling",
  "pages": 345,
  "isbn": "233872373",
  "image": "https://..."} }*

### Create Bookmark
**POST** `https://book-worm-be.herokuapp.com/api/v1/bookmarks`
*{"student_id": 1,
   "book_id": 1,
   "date": "this is a date",
   "minutes": 30,
   "page_number": 45,
   "notes": "these are notes",
   "reaction": "this is a reaction"}*
   
### Find Bookmarks for a Specific Book
**GET** `https://book-worm-be.herokuapp.com/api/v1/students/bookmarks`
*{"student_id": 1,
  "book_id": 1}*
  
### Finish/Abandon a Book
**PATCH** `https://book-worm-be.herokuapp.com/api/v1/student_books/:id`
*{"student_id": 123,
  "book_id": 4,
   "status": "finished",
   "review": "4",
   "review_comment": "A pretty good book, but I didn't like the ending."}*

## Database Schema
![Screen Shot 2021-04-19 at 3 02 03 PM](https://user-images.githubusercontent.com/69832134/115303032-51e63980-a120-11eb-956e-fbee36df9478.png)

## Future Iterations
Web push notifications when a friend starts and finishes a book.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- CONTACT -->
## Contact

- Catherine Dean - [Github](https://github.com/catherinemdean15) [LinkedIn](https://www.linkedin.com/in/catherine-dean-57a92030/)
- Joe Jiang - [Github](https://github.com/ninesky00) [LinkedIn](https://www.linkedin.com/in/joe-jiang01/)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/book-worm-2010/book-worm-be.svg?style=for-the-badge
[contributors-url]: https://github.com/book-worm-2010/book-worm-be/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/book-worm-2010/book-worm-be.svg?style=for-the-badge
[forks-url]: https://img.shields.io/github/forks/book-worm-2010/book-worm-be
[stars-shield]: https://img.shields.io/github/stars/book-worm-2010/book-worm-be.svg?style=for-the-badge
[stars-url]: https://github.com/book-worm-2010/book-worm-be/stargazers
[issues-shield]: https://img.shields.io/github/issues/book-worm-2010/book-worm-be
[issues-url]: https://github.com/book-worm-2010/book-worm-be/issues
[product-screenshot]: images/screenshot.png
