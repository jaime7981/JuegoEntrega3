from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from user_control.models import Player

from .serializers import *
from .models import Game, Lobby, Question, Round, Answer

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

class LobbyViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Lobby.objects.all()
    serializer_class = LobbySerializer

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
