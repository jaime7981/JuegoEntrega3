# InteligentTutoringSystem

## Functionality
- The route of the URL is defined in the url.py file
- The url route links up to the view.py file
- The view.py file loads the html and data

# API Endpoints
## Players
 - All Users -> GET base_url/usercontrol/players/
 - Add User -> POST base_url/usercontrol/players/ form_requires: {username, password1, password2}
 - User by Id -> GET base_url/usercontrol/players/(int)
 - Modify User -> PUT base_url/usercontrol/players/(int) **Need Fix**
 - Delete User -> DELETE base_url/usercontrol/players/(int) **Need Fix**

## Friend Requests
 - All Friend Requests -> GET base_url/usercontrol/friend_requests/
 - Add Friend Request -> POST base_url/usercontrol/friend_requests/ form_requires: {sender_player (player_api_link), reciever_player (player_api_link), acepted_request}
 - Friend Request By Id -> GET base_url/usercontrol/friend_requests/(int)
 - Modify Friend Request -> PUT base_url/usercontrol/friend_requests/(int) **Need Fix**
 - Delete Friend Request -> DELETE base_url/usercontrol/friend_requests/(int) **Need Fix**


## General Tasks
- [ ] Make models and database
- [ ] Create login and registration
- [ ] add more tasks...

## Deployment
- Launch docker container -> `docker-compose up --build`
- Return to shell -> `COMMAND &>/dev/null &`
- Launch docker container shell -> `docker exec -it [container-id] bash`
- watch user running jobs -> `jobs`