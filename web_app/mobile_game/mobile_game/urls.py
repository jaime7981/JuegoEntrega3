"""mobile_game URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include

from rest_framework.authtoken import views as django_auth
from rest_framework import routers

from user_control import views as usercontrol
from game_api import views as game_api

router = routers.DefaultRouter()
# user control endpoints
router.register('players', usercontrol.PlayerViewSet)
router.register('friend_requests', usercontrol.FriendRequestsViewSet)

# game endpoints
router.register('game', game_api.GameViewSet)
router.register('lobby', game_api.LobbyViewSet)
router.register('question', game_api.QuestionViewSet)
router.register('round', game_api.RoundViewSet)
router.register('answer', game_api.AnswerViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('api-token-auth/', django_auth.obtain_auth_token),
]
