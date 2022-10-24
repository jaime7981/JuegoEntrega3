from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from user_control.models import Player

from .serializers import *
from .models import Game, Lobby, Question, Round, Answer

import logging, random
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
    
    @action(methods=['post'], detail=False)
    def reset(self, request, *args, **kwargs):
        # get game
        game = Game.objects.get(id = request.data['game_id'])

        # set one player to answer
        joined = Lobby.objects.filter(game = game).filter(acepted_request=True).order_by('id')[:10]
        items = list(joined)
        random.shuffle(items)
        flag = True
        for player in items:
            if flag == True:
                player.player_state = 'A'
                flag = False
            else:
                player.player_state = 'W'
            player.save(update_fields=['player_state'])

        # assign a new question
        question = Question.objects.all()
        count = Question.objects.count()
        round = Round.objects.get(game=game)
        round.question = question[randint(0, count - 1)]
        if len(joined) == 1:
            round.round_state = 'A'
            game.game_state = 'A'
        else:
            round.round_state = 'W'
            game.game_state = 'W'
        
        #set game state to writing if not alone
        game.save(update_fields=['game_state'])
        round.save(update_fields=['question', 'round_state'])

        serializer = GameSerializer(game, many=False)
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
    def round_by_game(self, request, *args, **kwargs):
        game = Game.objects.get(id = request.data['game_id'])
        round = Round.objects.filter(game=game)
        serializer = RoundSerializer(round, many=True)
        return Response(serializer.data)

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

    @action(methods=['post'], detail=False)
    def round_answers_by_game(self, request, *args, **kwargs):
        game = Game.objects.get(id = request.data['game_id'])
        round = Round.objects.get(game=game)
        answers = Answer.objects.filter(round=round)
        serializer = AnswerSerializer(answers, many=True)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def round_answers_by_round(self, request, *args, **kwargs):
        round = Round.objects.get(id = request.data['round_id'])
        answers = Answer.objects.filter(round=round)
        serializer = AnswerSerializer(answers, many=True)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def change_to_answer(self, request, *args, **kwargs):
        # get game
        game = Game.objects.get(id = request.data['game_id'])

        # change game state
        game.game_state = 'A'
        game.save(update_fields=['game_state'])

        serializer = GameSerializer(game, many=False)
        return Response(serializer.data)
