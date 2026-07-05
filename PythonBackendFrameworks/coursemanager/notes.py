"""
TASK 1

1. Request-Response Cycle

Browser
   |
   | HTTP GET Request
   |
URL Router (urls.py)
   |
View (views.py)
   |
Model (models.py) -> Database
   |
View
   |
HttpResponse
   |
Browser

------------------------------------------------

2. Middleware

Middleware sits between the request and the response.

Examples:

SecurityMiddleware
- Protects against security attacks.

AuthenticationMiddleware
- Associates authenticated users with each request.

------------------------------------------------

3. WSGI vs ASGI

WSGI:
- Handles synchronous requests.
- Default interface used by Django.

ASGI:
- Handles asynchronous requests.
- Supports WebSockets and real-time applications.

Use ASGI for chat applications, live notifications,
and other asynchronous features.

------------------------------------------------

4. MVC vs MVT

MVC

Model      -> Model
View       -> User Interface
Controller -> Business Logic

Django MVT

Model      -> Model
View       -> Controller
Template   -> User Interface
"""