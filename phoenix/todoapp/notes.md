# Json
http://localhost:4000/api/todos
http://localhost:4000/api/todos/1

 curl -i -H "Accept: application/json" localhost:4000/api/todos

# Web Socket

Channels are distinct connection (like chat room). You can create several channels
 -  join(topic, _params, socket)
    - When user/client initially joins a channel

 -  handle-in(topic, message, socket)
    - receive events coming from client/browser


Quick test:
- 