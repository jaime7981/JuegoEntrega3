from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from .models import Player, FriendRequests
from rest_framework import serializers
from django.contrib.auth.password_validation import validate_password

class RegisterSerializer(serializers.ModelSerializer):
    password1 = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = User
        fields = ['username', 'password1', 'password2']

    def validate(self, attrs):
        if attrs['password1'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})
        return attrs

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username']
        )
        user.set_password(validated_data['password1'])
        user.save()
        Player.objects.create(user=user)
        Token.objects.create(user=user)
        return user

class SentFriendRequestSerializer(serializers.ModelSerializer):
    sender_player = serializers.CharField(write_only=True, required=True)
    reciever_player = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = FriendRequests
        fields = ['sender_player', 'reciever_player', 'acepted_request']

    def validate(self, attrs):
        sender = Player.objects.get(user = User.objects.get(username = attrs['sender_player']))
        reciever = Player.objects.get(user = User.objects.get(username = attrs['reciever_player']))
        sent_check = FriendRequests.objects.filter(sender_player=sender).filter(reciever_player=reciever).exists()
        recieved_check = FriendRequests.objects.filter(sender_player=reciever).filter(reciever_player=sender).exists()
        if sender == None or reciever == None:
            raise serializers.ValidationError({"user": "User dont exist."})
        elif sent_check:
            raise serializers.ValidationError({'friend_request':'Friend request already sent.'})
        elif recieved_check:
            raise serializers.ValidationError({'friend_request':'Friend request already sent by the other player.'})
        return attrs

    def create(self, validated_data):
        sender = Player.objects.get(user = User.objects.get(username = validated_data['sender_player']))
        reciever = Player.objects.get(user = User.objects.get(username = validated_data['reciever_player']))
        friend_request = FriendRequests.objects.create(
            sender_player=sender,
            reciever_player=reciever,
            acepted_request=False
        )
        friend_request.save()
        return friend_request

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username']

class PlayerSerializer(serializers.HyperlinkedModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Player
        fields = ['user', 'matches_won', 'matches_lost', 'best_score']

class TokenSerializer(serializers.ModelSerializer):
    class Meta:
        model = Token
        fields = '__all__'

class FriendRequestsSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendRequests
        fields = ['sender_player', 'reciever_player', 'acepted_request']
