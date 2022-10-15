from email.policy import default
from random import choices
from django.db import models
from user_control.models import Player

class Game(models.Model): #Done
    GAME_STATES = (
        ('W', 'Writing'),
        ('A', 'Answering'),
        ('S', 'Starting'),
    )

    host = models.ForeignKey(Player, on_delete=models.CASCADE, blank=True, null=True)
    game_state = models.CharField(max_length=1, choices=GAME_STATES)
    name = models.CharField(max_length=100)

    def __str__(self):
        return str([self.host, self.game_state])

class Lobby(models.Model): #Done
    PLAYER_STATES = (
        ('R', 'Ready'),
        ('W', 'Waiting'),
        ('A', 'Answering'),
    )

    game = models.ForeignKey(Game, null=True, on_delete=models.CASCADE)
    player = models.ForeignKey(Player, null=True, on_delete=models.CASCADE)
    player_state = models.CharField(max_length=1, choices=PLAYER_STATES)
    points = models.IntegerField(default=0, null=True, blank=True)
    acepted_request = models.BooleanField(default=False)

    def __str__(self):
        return str(self.game)

class Question(models.Model): #Done
    question = models.CharField(max_length=100)
    correct_answer = models.CharField(max_length=100)
    ans_1 = models.CharField(max_length=100)
    ans_2 = models.CharField(max_length=100)
    ans_3 = models.CharField(max_length=100)
    ans_4 = models.CharField(max_length=100)

    def __str__(self):
        return str(self.question)

class Round(models.Model): #
    ROUND_STATES = (
        ('W', 'Writing'),
        ('A', 'Answering'),
        ('S', 'Starting'),
    )

    game = models.ForeignKey(Game, null=True, on_delete=models.CASCADE)
    question = models.ForeignKey(Question, null=True, on_delete=models.CASCADE)
    round_state = models.CharField(max_length=1, choices=ROUND_STATES)

    def __str__(self):
        return str(self.game)

class Answer(models.Model):
    PLAYER_STATES = (
        ('R', 'Ready'),
        ('W', 'Waiting'),
        ('A', 'Answering'),
    )

    round = models.ForeignKey(Round, null=True, on_delete=models.CASCADE)
    player = models.ForeignKey(Player, null=True, on_delete=models.CASCADE)
    answer_state = models.CharField(max_length=1, choices=PLAYER_STATES)
    player_answer = models.CharField(max_length=100)

    def __str__(self):
        return str(self.player_answer)

