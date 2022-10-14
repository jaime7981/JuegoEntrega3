from django.db import models
from user_control.models import Player

class Game(models.Model): #Done
    host = models.OneToOneField(Player, on_delete=models.CASCADE, blank=True, null=True)
    game_state = models.CharField()

    def __str__(self):
        return str([self.host, self.game_state])

class Lobby(models.Model): #Done
    game = models.ForeignKey(Game, null=True, on_delete=models.CASCADE)
    player = models.ForeignKey(Player, null=True, on_delete=models.CASCADE)
    player_state = models.CharField()
    points = models.IntegerField(default=0, null=True, blank=True)

    def __str__(self):
        return str(self.game)

class Question(models.Model): #Done
    question = models.CharField()
    correct_answer = models.CharField()
    ans_1 = models.CharField()
    ans_2 = models.CharField()
    ans_3 = models.CharField()
    ans_4 = models.CharField()

    def __str__(self):
        return str(self.question)

class Round(models.Model): #Done
    game = models.ForeignKey(Game, null=True, on_delete=models.CASCADE)
    question = models.ForeignKey(Question, null=True, on_delete=models.CASCADE)
    round_state = models.CharField()

    def __str__(self):
        return str(self.game)

class Answer(models.Model):
    round = models.ForeignKey(Round, null=True, on_delete=models.CASCADE)
    player = models.ForeignKey(Player, null=True, on_delete=models.CASCADE)
    answer_state = models.CharField()
    player_answer = models.CharField()

    def __str__(self):
        return str(self.player_answer)

