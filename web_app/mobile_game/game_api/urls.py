from django.urls import path, include
from rest_framework import routers

from . import views as game_api

router = routers.DefaultRouter()
router.register('game', game_api.GameViewSet)
router.register('lobby', game_api.LobbyViewSet)
router.register('question', game_api.QuestionViewSet)
router.register('round', game_api.RoundViewSet)
router.register('answer', game_api.AnswerViewSet)

urlpatterns = [
    path('', include(router.urls)),
]