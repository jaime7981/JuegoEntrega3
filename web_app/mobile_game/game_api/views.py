from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from user_control.models import Player

from .serializers import *
from .models import Game, Lobby, Question, Round, Answer

import logging
logger = logging.getLogger('django')

class GameViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Game.objects.all()
    serializer_class = GameSerializer

    def create(self, request):
        serializer = CreateGameSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

    @action(methods=['get'], detail=False)
    def user_created_games(self, request, *args, **kwargs):
        player = Player.objects.get(user = request.user)
        items = Game.objects.filter(host=player)
        serializer = GameSerializer(items, many=True)
        return Response(serializer.data)

class LobbyViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Lobby.objects.all()
    serializer_class = LobbySerializer

    games = Game.objects.all()
    games_serializer = GameSerializer

    @action(methods=['get'], detail=False)
    def acepted(self, request, *args, **kwargs):
        player = Player.objects.get(user=request.user)
        acepted = Lobby.objects.filter(acepted_request=True).filter(player=player)
        serializer = LobbySerializer(acepted, many=True)
        return Response(serializer.data)


    @action(methods=['get'], detail=False)
    def recieved(self, request, *args, **kwargs):
        player = Player.objects.get(user=request.user)
        items = Lobby.objects.filter(acepted_request=False).filter(player=player)
        serializer = LobbySerializer(items, many=True)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def send_lobby_request(self, request, *args, **kwargs):
        serializer = CreateLobbySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def joined(self, request, *args, **kwargs):
        joined= Lobby.objects.filter(game = request.data['game_id']).filter(acepted_request=True)
        serializer = LobbySerializer(joined, many=True)
        return Response(serializer.data)

class QuestionViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Question.objects.all()
    serializer_class = QuestionSerializer

class RoundViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Round.objects.all()
    serializer_class = RoundSerializer

    @action(methods=['post'], detail=False)
    def random_question(self, request, *args, **kwargs):
        serializer = CreateRoundSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

class AnswerViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Answer.objects.all()
    serializer_class = AnswerSerializer
