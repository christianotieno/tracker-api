# Schedule-Tracker API Documentation

- This API uses `POST` request to communicate and HTTP [response codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) to indenticate status and errors.
- It is holds the Ruby on Rails API from which the React frontend (tracker-client) serves the data.

- It is a simple Rails app that has three models - User, Schedule and Task

- The API is hosted on Heroku.

## Response Codes

### Expected Response Codes

```
200: Success
400: Bad request
401: Unauthorized
404: Cannot be found
405: Method not allowed
422: Unprocessable Entity
50X: Server Error
```

### Error Codes Details

```
100: Bad Request
110: Unauthorized
120: User Authenticaion Invalid
130: Parameter Error
140: Item Missing
150: Conflict
160: Server Error
```

### Example Error Message

```json
http code 402
{
    "code": 120,
    "message": "invalid crendetials",
    "resolve": "The name or password is not correct."
}
```

### Endpoints

|Endpoint|Method|Description|
|:---|:---|:---|
|`/login`|POST|For user login|
|`/signup`|POST|For user sign up|
|`/logout`|DELETE|For logging out|
|`/users/:user_id/schedules`|GET|For fetching the user's schedules|
|`/users/:user_id/schedules`|POST|For creating the user's schedules|
|`/users/:user_id/schedules/:id`|POST|For creating a user's schedule|
|`/users/:user_id/schedules/:id`|PUT|fFor updating the user's schedule|
|`/users/:user_id/schedules/:id`|PATCH|For updating the user's schedule|
|`/users/:user_id/schedules/:id`|DELETE|For removing the user's schedule|
|`/users/:user_id/schedules/:id`|GET|For fetching one particular user's schedule|
|`/users/:user_id/schedules/:schedule_id/tasks`|GET|For fetching user's tasks for the current schedule|
|`/users/:user_id/schedules/:schedule_id/tasks`|POST|for creating user's tasks in the specified schedule|
|`/users/:user_id/schedules/:schedule_id/tasks/:id`|GET|For fetching specifi user's task for the current schedule|
|`/users/:user_id/schedules/:schedule_id/tasks/:id`|POST|For creating a user's task to the current user's schedule list|
|`/users/:user_id/schedules/:schedule_id/tasks/:id`|DELETE|For removing a user's task from the current user's schedule list|
|`/users/:user_id/schedules/:schedule_id/tasks/:id`|PATCH|For updating a section of the a user's tasks from the current user's schedule list|
|`/users/:user_id/schedules/:schedule_id/tasks/:id`|PUT|For updating the entire state of the user's task from the current user's schedule list|

### Built With

1. Ruby on Rails
2. PostgreSQL
3. Rubocop

### Setup

```
git clone git@github.com:christianotieno/tracker-api.git
```

#### Install dependencies

```
bundle install
```

#### Start Development Server

```
rails s
```

#### Visit this link in your browser

```
http://localhost:4000/
```

#### Run Rubocop

```
rubocop
```

#### Run tests

```
bundle exec rspec
```

## Author

👤 **Christian Otieno**

- Github: [christianotieno](https://github.com/christianotieno)
- Twitter: [@iamchrisotieno](https://twitter.com/iamchrisotieno)
- LinkedIn: [christianotieno](https://www.linkedin.com/in/christianotieno/)
- Personal website: [christianotieno.dev](https://christianotieno.dev/)

## 9. 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/christianotieno/tracker-api/issues).

---

## 10. Show your support

Give a ⭐️ if you like this project!

---

## 11. Acknowledgments & Credits

- Microverse
