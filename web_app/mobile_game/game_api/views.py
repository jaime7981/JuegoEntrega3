from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from user_control.models import Player

from .serializers import *
from .models import Game, Lobby, Question, Round, Answer

import logging, json
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
        player = Player.objects.get(id = request.user.id)
        items = Game.objects.filter(host=player)
        serializer = GameSerializer(items, many=True)
        return Response(serializer.data)

    @action(methods=['get'], detail=False)
    def game_by_id(self, request, *args, **kwargs):
        items = Game.objects.filter(id = request.id)
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
        acepted = Lobby.objects.filter(acepted_request=True).filter(player=request.user.id)
        serializer = LobbySerializer(acepted, many=True)
        logger.info(acepted)
        return Response(serializer.data)


    @action(methods=['get'], detail=False)
    def recieved(self, request, *args, **kwargs):
        items = Lobby.objects.filter(acepted_request=False).filter(player=request.user.id)
        serializer = LobbySerializer(items, many=True)
        logger.info(items)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def send_lobby_request(self, request, *args, **kwargs):
        serializer = CreateLobbySerializer(data=request.data)
        logger.info(request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def joined(self, request, *args, **kwargs):
        joined= Lobby.objects.filter(game = request.data['game_id']).filter(acepted_request=True)
        serializer = LobbySerializer(joined, many=True)
        logger.info(joined)

        #TODO: Then, in frontend, should just print the users.
        return Response(serializer.data)

    #Probably not needed, but would need some thought to implement...
    #The idea should be to look for all of the players that haven't accepted a game, and then give that information to the host of
    #the game, as he is the only one that can invite others.
    """
    @action(methods=['get'], detail=False)
    def sent(self, request, *args, **kwargs):
        items = Lobby.objects.filter(acepted_request=False).filter(game=request.game.id)
        serializer = LobbySerializer(items, many=True)
        return Response(serializer.data)
    """

    
    @action(methods=['get'], detail=False)
    def findGameById(self, request, *args, **kwargs):
        items = Game.objects.filter(id = request.game)
        serializer = GameSerializer(items, many=True)
        logger.info(items)
        return Response(serializer.data)




"""
class LobbyRequestsViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = LobbyRequests.objects.all()
    serializer_class = LobbyRequestsSerializer

    @action(methods=['get'], detail=False)
    def acepted(self, request, *args, **kwargs):
        acepted = LobbyRequests.objects.filter(acepted_request=True)
        items = acepted.filter(sender_player=request.user.id) | acepted.filter(reciever_player=request.user.id)
        serializer = LobbyRequestsUsernameSerializer(items, many=True)
        logger.info(items)
        return Response(serializer.data)

    #May not be needed, but implemented still just in case...
    @action(methods=['get'], detail=False)
    def sent(self, request, *args, **kwargs):
        items = LobbyRequests.objects.filter(acepted_request=False).filter(sender_player=request.user.id)
        serializer = LobbyRequestsUsernameSerializer(items, many=True)
        return Response(serializer.data)
    
    @action(methods=['get'], detail=False)
    def recieved(self, request, *args, **kwargs):
        items = LobbyRequests.objects.filter(acepted_request=False).filter(reciever_player=request.user.id)
        serializer = LobbyRequestsUsernameSerializer(items, many=True)
        logger.info(items)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def send_lobby_request_by_username(self, request):
        serializer =SentLobbyRequestSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)
"""

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

class AnswerViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Answer.objects.all()
    serializer_class = AnswerSerializer
