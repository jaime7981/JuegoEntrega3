from rest_framework import serializers
from .models import Game, Lobby, Question, Round, Answer
from user_control.models import Player

class GameSerializer(serializers.ModelSerializer):
    class Meta:
        model = Game
        fields = '__all__'

class CreateGameSerializer(serializers.ModelSerializer):
    host = serializers.IntegerField(write_only=True, required=True)
    game_state = serializers.CharField(write_only=True, required=True)
    name = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = Game
        fields = ['host', 'game_state', 'name']

    def validate(self, attrs):
        return attrs

    def create(self, validated_data):
        game = Game.objects.create(
            host=Player.objects.get(id=validated_data['host']),
            game_state='S',
            name=validated_data['name'],
        )
        game.save()
        lobby = Lobby.objects.create(game=game,
                             player=game.host,
                             player_state='R',
                             points=0,
                             acepted_request=True)
        lobby.save()
        return game

class LobbySerializer(serializers.ModelSerializer):
    class Meta:
        model = Lobby
        fields = '__all__'

class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = '__all__'

class RoundSerializer(serializers.ModelSerializer):
    class Meta:
        model = Round
        fields = '__all__'

class AnswerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Answer
        fields = '__all__'
