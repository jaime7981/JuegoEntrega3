from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Player(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, blank=True, null=True)

    def __str__(self):
        return str(self.user)

class FriendRequests(models.Model):
    sender_player = models.ForeignKey(Player, null=True, related_name='sender_player', on_delete=models.CASCADE)
    reciever_player = models.ForeignKey(Player, null=True, related_name='reciever_player', on_delete=models.CASCADE)
    acepted_request = models.BooleanField()

    def __str__(self):
        return str([self.sender_player, self.reciever_player, self.acepted_request])