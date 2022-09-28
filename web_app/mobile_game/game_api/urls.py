from django.urls import path
from . import views as game_api
from django.views.generic import RedirectView

urlpatterns = [
    path('', RedirectView.as_view(url='/game/active_games')),
    path('active_games', game_api.activeGames, name = 'active_games'),
    path('join_game', game_api.joinGame, name = 'join_game'),
]