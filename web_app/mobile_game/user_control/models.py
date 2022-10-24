from email.policy import default
from django.db import models
from django.contrib.auth.models import User
import datetime

# Create your models here.
class Player(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, blank=True, null=True)

    matches_won = models.IntegerField(default=0, null=True, blank=True)
    matches_lost = models.IntegerField(default=0, null=True, blank=True)
    total_matches = models.IntegerField(default=0, null=True, blank=True)
    match_percentage = models.IntegerField(default=0, null=True, blank=True)

    creation_date = models.DateField(default= datetime.date.today()) 
    current_date = models.DateField(default= datetime.date.today())

    #Estadisticas interesantes:
    #1. Mejor puntaje
    best_score = models.IntegerField(default=0, null=True, blank=True)

    #2. Mejor respuesta
    best_answer = models.CharField(max_length=100)

    #3. Porcentaje de rondas ganadas
    played_rounds = models.IntegerField(default=0, null=True, blank=True)
    won_rounds = models.IntegerField(default=0, null=True, blank=True)
    round_percentage = models.IntegerField(default=0, null=True, blank=True)

    #4. ¿Tiene muchos amigos?
    # Algunos amigos = 'A veces me gusta hablar con gente' ; Muchos amigos = 'Me sé hasta tu dirección ip.'
    friends_amount = models.IntegerField(default=0, null=True, blank=True)
    many_friends = models.CharField(max_length=100, default="No tengo amigos")

    #5. ¿Juega con muchos amigos o prefiere jugar sólo?
    # Muchas invitaciones creadas = 'Alma de la fiesta' ; Pocas invitaciones = 'Batman trabaja sólo'
    invites_made = models.IntegerField(default=0, null=True, blank=True)
    group_playing = models.CharField(max_length=100, default = "Yo literalmente no sé jugar")


    #friends = models.ManyToManyField(Player, through='FriendRequests')

    def __str__(self):
        return str(self.user)

class FriendRequests(models.Model):
    sender_player = models.ForeignKey(Player, null=True, related_name='sender_player', on_delete=models.CASCADE)
    reciever_player = models.ForeignKey(Player, null=True, related_name='reciever_player', on_delete=models.CASCADE)
    acepted_request = models.BooleanField()

    def __str__(self):
        return str([self.sender_player, self.reciever_player, self.acepted_request])