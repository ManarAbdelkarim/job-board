# Job Application App

This README provides information on how to set up and run the Job Application App.

## Getting Started

Follow the steps below to set up and run the application:

### Prerequisites

*Database:*
- SQLite 3.8.0 and up

*Dependencies:*
- Ruby 3.2.2
- Rails 7.0.7
- Gem 3.4.10

### Configuration

1.Installing Dependencies:
```bundle install```

2.Database Creation:
   ```
   rails db:create
   ```
3.Database Initialization:
```
rails db:migrate
```
4.Running Seeds:
```rails db:seed```
5.Running the Application:
```rails server```

Note that by default it will be localhost:3000

### Usage


| API Endpoint                 | HTTP Method | Expected Status | Example Request                                         | Example Response                                      |
|------------------------------|-------------|-----------------|---------------------------------------------------------|-------------------------------------------------------|
| `/signup`                    | POST        | 201 Created     | `POST /signup`<br>Request Body: { "email": "user@example.com", "password": "password123" } | Newly created user data                              |
| `/login`                     | POST        | 200 OK          | `POST /login`<br>Request Body: { "email": "user@example.com", "password": "password123" } | JSON object with user data and token                |
| `/job_posts`                 | GET         | 200 OK          | `GET /job_posts`                                       | List of job posts                                    |
| `/job_posts/:id`             | GET         | 200 OK          | `GET /job_posts/1`                                     | JSON object containing details of the job post      |
| `/job_posts`                 | POST        | 201 Created     | `POST /job_posts`<br>Request Body: { "title": "Software Engineer", "description": "..." } | Newly created job post data                          |
| `/job_posts/:id`             | PATCH/PUT   | 200 OK          | `PATCH /job_posts/1`<br>Request Body: { "title": "Updated Title" } | Updated job post data                               |
| `/job_posts/:id`             | DELETE      | 204 No Content  | `DELETE /job_posts/1`                                  | No content                                          |
| `/job_applications`          | GET         | 200 OK          | `GET /job_applications`                               | List of job applications (based on user's role)    |
| `/job_applications/:id`      | GET         | 200 OK          | `GET /job_applications/1`                             | JSON object containing details of the job application |
| `/job_applications`          | POST        | 201 Created     | `POST /job_applications`<br>Request Body: { "user_id": 1, "job_post_id": 1, "status": "applied" } | Newly created job application data                   |
| `/job_applications/:id`      | PATCH/PUT   | 200 OK          | `PATCH /job_applications/1`<br>Request Body: { "status": "in_review" } | Updated job application data                        |
| `/job_applications/:id`      | DELETE      | 204 No Content  | `DELETE /job_applications/1`                          | No content                                          |
