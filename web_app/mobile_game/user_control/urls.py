from django.urls import path, include
from . import views as usercontrol
from rest_framework import routers

router = routers.DefaultRouter()
router.register('users', usercontrol.PlayerViewSet)
router.register('friend_requests', usercontrol.FriendRequestsViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('login', usercontrol.login, name = 'login'),
    path('registration', usercontrol.registration, name = 'registration'),
    path('logout', usercontrol.logout, name = 'logout'),
]