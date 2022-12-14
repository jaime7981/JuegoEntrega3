from random import randint, random
from rest_framework import serializers
from .models import Game, Lobby, Question, Round, Answer
from user_control.models import Player
from django.contrib.auth.models import User

class GameSerializer(serializers.ModelSerializer):
    class Meta:
        model = Game
        fields =  ['id', 'host', 'game_state', 'name']

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
        user = User.objects.get(id=validated_data['host'])
        game = Game.objects.create(
            host=Player.objects.get(user=user),
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
        question = Question.objects.all()
        count = Question.objects.count()
        round = Round.objects.create(
            game=game,
            question=question[randint(0, count - 1)],
            round_state ='S',
        )
        round.save()
        return game

class LobbySerializer(serializers.ModelSerializer):
    class Meta:
        model = Lobby
        fields = ['id', 'game', 'player','player_state', 'points', 'acepted_request']

class CreateLobbySerializer(serializers.ModelSerializer):
    game = serializers.CharField(write_only=True, required=True)
    player = serializers.CharField(write_only=True, required=True)
    player_state = serializers.CharField(write_only=True, required=True)
    points = serializers.IntegerField(write_only=True, required=True)
    acepted_request = serializers.BooleanField(write_only=True, required=True)

    class Meta:
        model = Game
        fields = ['game', 'player','player_state', 'points', 'acepted_request']

    def validate(self, attrs):
        return attrs

    def create(self, validated_data):
        lobby = Lobby.objects.create(
            game=Game.objects.get(id=validated_data['game']),
            player=Player.objects.get(user = User.objects.get(username = validated_data['player'])),
            player_state ='R',
            points = 0,
            acepted_request = False
        )
        lobby.save()
        return lobby    

class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = '__all__'

class RoundSerializer(serializers.ModelSerializer):
    class Meta:
        model = Round
        fields = '__all__'

class CreateRoundSerializer(serializers.ModelSerializer):
    game = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = Round
        fields = ['game']

    def validate(self, attrs):
        return attrs

    def create(self, validated_data):
        question = Question.objects.all()
        count = Question.objects.count()
        round = Round.objects.create(
            game=Game.objects.get(id=validated_data['game']),
            question=question[randint(0, count - 1)],
            round_state ='S',
        )
        round.save()
        return round

class AnswerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Answer
        fields = '__all__'
