from django.urls import path, include
from rest_framework import routers

from . import views as game_api

router = routers.DefaultRouter()
router.register('game', game_api.GameViewSet)
router.register('lobby', game_api.LobbyViewSet)

"""
#Added lobby requests, as to separate the lobby itself from a players state during a game (considering that in our model, game is just 
# a register of who created a game, and if it's still active).
router.register('lobby_requests', game_api.LobbyRequestsViewSet)
"""
router.register('question', game_api.QuestionViewSet)
router.register('round', game_api.RoundViewSet)
router.register('answer', game_api.AnswerViewSet)

urlpatterns = [
    path('', include(router.urls)),
]